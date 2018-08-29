//本例子程序提供操作方法，仅供参考
// *******************************************************************
// Website:  http://wch.cn
// Email:    tech@wch.cn
// Author:   TECH  2008.12.05
// *******************************************************************

//ICCAVR下编译

// **************************************
// 加载头文件
// **************************************
#include <iom16v.h>
#include <macros.h>

// **************************************
// CH423定义
// **************************************
#define				CH423_SDA_OUT   	{ DDRC |= (1<<PC1); }
#define				CH423_SDA_IN		{ PORTC |= (1<<PC1); DDRC &= ~(1<<PC1); }
#define			 	CH423_SDA_SET		PORTC |= (1<<PC1)
#define			 	CH423_SDA_CLR		PORTC&=~(1<<PC1)
#define			 	CH423_SDA			( PINC & (1<<PC1) )
#define			 	CH423_SCL_OUT		{ PORTC |= (1<<PC0); DDRC |= (1<<PC0); }
#define			 	CH423_SCL_SET		PORTC |= (1<<PC0)
#define			 	CH423_SCL_CLR		PORTC &= ~(1<<PC0) 
#define				DELAY			    { NOP();NOP();NOP();NOP();NOP();NOP();NOP();NOP(); }

#define 			DOT_				0x80
#define             CH423_SYSTEM        0x4800
#define             CH423_OCL           0x4400
#define             CH423_OCH           0x4600
#define             CH423_IO        	0x6000
#define             CH423_DIG0        	0x6000 
#define             CH423_DIG1        	0x6200 
#define             CH423_DIG2        	0x6400
#define             CH423_DIG3        	0x6600
#define             CH423_DIG4        	0x6800 
#define             CH423_DIG5        	0x6A00 
#define             CH423_DIG6        	0x6C00
#define             CH423_DIG7        	0x6E00
#define             CH423_DIG8        	0x7000 
#define             CH423_DIG9        	0x7200 
#define             CH423_DIG10        	0x7400
#define             CH423_DIG11        	0x7600
#define             CH423_DIG12        	0x7800 
#define             CH423_DIG13        	0x7A00 
#define             CH423_DIG14        	0x7C00
#define             CH423_DIG15        	0x7E00
#define             CH423_RD        	0x4D00
#define             CH423_SYS0        	0x00
#define             CH423_SYS1        	0x01
#define             CH423_SYS2        	0x17

// **************************************
// 延时毫秒，不准
// **************************************
void mDelaymS( unsigned char ms )    // 延时毫秒，不准
{
    unsigned short i;
    while ( ms -- )
    {
        for( i = 0; i != 3000; i++ );
    }
}

//     7 1 F 8 9 A
//6 5 4 2 3  |  C E D 0 B
// **************************************
// BCD码表
// **************************************
const unsigned char BCD_decode_tab[ 29 ] = { 
                                               0X3F, 0X06, 0X5B, 0X4F, 0X66, 0X6D, 0X7D, 0X07, 0X7F, 0X6F, 
                                               0X77, 0X7C, 0X58, 0X5E, 0X79, 0X71, 0x00, 0x46, 0x40, 0x41, 
											   0x39, 0x0F, 0x08, 0x76, 0x38, 0x73, 0x80, 0xFF, 0x00 
										   };

// **************************************
// I2C START
// **************************************									   
void CH423_I2c_Start( void )
{
	CH423_SDA_SET; /*发送起始条件的数据信号*/
	CH423_SDA_OUT;  /* 设置SDA为输出方向 */
 	DELAY;
	
	CH423_SCL_SET;/* 设置SCL为输出方向 */
	DELAY;
	
	CH423_SDA_CLR;   /*发送起始信号*/
	DELAY;    
	  
	CH423_SCL_CLR;  /*钳住I2C总线，准备发送或接收数据 */
	DELAY;
}

// **************************************
// I2C STOP
// **************************************	
void CH423_I2c_Stop( void )
{
	CH423_SDA_CLR; 
	CH423_SDA_OUT; /* 设置SDA为输出方向 */
	DELAY;
	
	CH423_SCL_SET; 
	DELAY;
	
	CH423_SDA_SET; /*发送I2C总线结束信号*/
	DELAY;   
	
	CH423_SDA_IN; /* 设置SDA为输入方向 */
	DELAY; 
}

// **************************************
// I2C 写一个字节
// **************************************
void CH423_I2c_WrByte( unsigned char c )	//写一个字节数据
{
	unsigned char i;
	
	CH423_SDA_SET;
	CH423_SDA_OUT; /* 设置SDA为输出方向 */
	DELAY;
	
	for( i = 0; i != 8; i++ ) 
	{
		if( c & 0x80 ) { CH423_SDA_SET; }
		else { CH423_SDA_CLR; }
		DELAY;
		
		CH423_SCL_SET;
		
		c <<= 1;
		DELAY;
		
		CH423_SCL_CLR;
	}
	
	CH423_SDA_IN;   /* 设置SDA为输入方向 */
	DELAY;
	
	CH423_SCL_SET;  
	DELAY;
	
	CH423_SCL_CLR;
	DELAY;
}

// **************************************
// I2C 读一个字节
// **************************************
unsigned char  CH423_I2c_RdByte( void )		//读一个字节数据
{
	unsigned char c, i;
	
	CH423_SDA_IN;   /* 设置SDA为输入方向 */
	
	c = 0;
	for( i = 0; i != 8; i++ )  // 输入8位数据
	{
		CH423_SCL_SET;
		DELAY;
		
		c <<= 1;
		if( CH423_SDA ) c++;  // 输入1位
		
		CH423_SCL_CLR;
		DELAY;
	}
	
	CH423_SDA_SET;
	CH423_SDA_OUT;
	
	CH423_SCL_SET;  // 发出无效应答
	DELAY;
	
	CH423_SCL_CLR;
	DELAY;
	
	return(c);
}

// **************************************
// CH423写命令
// **************************************
void CH423_Write( unsigned short command )	//写命令
{	
     CH423_I2c_Start();               /*启动总线*/
   	 CH423_I2c_WrByte( (unsigned char)(command>>8) ); 
   	 CH423_I2c_WrByte( (unsigned char)command );               /*发送数据*/
  	 CH423_I2c_Stop();                 /*结束总线*/
}

// **************************************
// CH423读命令
// **************************************
unsigned char CH423_Read( void )	//读命令
{	
     unsigned short command = CH423_RD;
	 unsigned char val;
	 
     CH423_I2c_Start();               /*启动总线*/
   	 CH423_I2c_WrByte( (unsigned char)(command>>8) ); 
   	 val = CH423_I2c_RdByte( );               /*读数据*/
  	 CH423_I2c_Stop();                 /*结束总线*/
	 
	 return val;
}

// **************************************
// CH423设置模式0
// **************************************
void CH423_SetMode0( void )
{
 	 CH423_Write( CH423_SYSTEM | CH423_SYS0 );//启用IO扩展功能，IO7-IO0为输入，OC15-OC0为开漏输出
}

// **************************************
// CH423设置模式1
// **************************************
void CH423_SetMode1( void )
{
 	 CH423_Write( CH423_SYSTEM | CH423_SYS1 );//启用IO扩展功能，IO7-IO0为输出，OC15-OC0为开漏输出
}

// **************************************
// CH423设置模式2
// **************************************
void CH423_SetMode2( void )
{
 	 CH423_Write( CH423_SYSTEM | CH423_SYS2 );//启用数码管自动扫描功能，SEG7～SEG0 和DIG15～DIG0 为输出
}

// **************************************
// CH423的IO7-IO0输出数据
// **************************************
void CH423_IO_Output( unsigned char output )
{
 	 CH423_Write( CH423_IO | output );//IO7-IO0输出
}

// **************************************
// CH423的OC15-OC8输出数据
// **************************************
void CH423_OCH_Output( unsigned char output )
{
 	 CH423_Write( CH423_OCH | output );//OC15-OC8输出
}

// **************************************
// CH423的OC7-OC0输出数据
// **************************************
void CH423_OCL_Output( unsigned char output )
{
 	 CH423_Write( CH423_OCL | output );//OC7-OC0输出
}

// **************************************
// 读CH423的IO7-IO0输入的数据
// **************************************
unsigned char CH423_IO_Input( void )
{
 	 return CH423_Read();//读IO7-IO0输入的数据
}

// **************************************
// CH423初始化
// **************************************
void CH423_Init( void )
{
 	 CH423_SCL_OUT;
	 CH423_SDA_SET;
	 CH423_SDA_OUT;
	 
	 mDelaymS( 30 );
	 
	 CH423_SetMode2();//启用数码管自动扫描功能，SEG7～SEG0 和DIG3～DIG0 为输出
	 
	 CH423_Write( CH423_DIG0 | BCD_decode_tab[0] );
	 CH423_Write( CH423_DIG1 | BCD_decode_tab[1] );
	 CH423_Write( CH423_DIG2 | BCD_decode_tab[2] );
	 CH423_Write( CH423_DIG3 | BCD_decode_tab[3] );
	 CH423_Write( CH423_DIG4 | BCD_decode_tab[4] );
	 CH423_Write( CH423_DIG5 | BCD_decode_tab[5] );
	 CH423_Write( CH423_DIG6 | BCD_decode_tab[6] );
	 CH423_Write( CH423_DIG7 | BCD_decode_tab[7] );
	 CH423_Write( CH423_DIG8 | BCD_decode_tab[8] );
	 CH423_Write( CH423_DIG9 | BCD_decode_tab[9] );
	 CH423_Write( CH423_DIG10 | BCD_decode_tab[10] );
	 CH423_Write( CH423_DIG11 | BCD_decode_tab[11] );
	 CH423_Write( CH423_DIG12 | BCD_decode_tab[12] );
	 CH423_Write( CH423_DIG13 | BCD_decode_tab[13] );
	 CH423_Write( CH423_DIG14 | BCD_decode_tab[14] );
	 CH423_Write( CH423_DIG15 | BCD_decode_tab[15] );
	 
	 mDelaymS( 255 );
	 mDelaymS( 255 );
	 mDelaymS( 255 );
	 mDelaymS( 255 );
	 
	 CH423_Write( CH423_DIG0 | BCD_decode_tab[0] | DOT_ );
	 CH423_Write( CH423_DIG1 | BCD_decode_tab[1] | DOT_ );
	 CH423_Write( CH423_DIG2 | BCD_decode_tab[2] | DOT_ );
	 CH423_Write( CH423_DIG3 | BCD_decode_tab[3] | DOT_ );
	 CH423_Write( CH423_DIG4 | BCD_decode_tab[4] | DOT_ );
	 CH423_Write( CH423_DIG5 | BCD_decode_tab[5] | DOT_ );
	 CH423_Write( CH423_DIG6 | BCD_decode_tab[6] | DOT_ );
	 CH423_Write( CH423_DIG7 | BCD_decode_tab[7] | DOT_ );
	 CH423_Write( CH423_DIG8 | BCD_decode_tab[8] | DOT_ );
	 CH423_Write( CH423_DIG9 | BCD_decode_tab[9] | DOT_ );
	 CH423_Write( CH423_DIG10 | BCD_decode_tab[10] | DOT_ );
	 CH423_Write( CH423_DIG11 | BCD_decode_tab[11] | DOT_ );
	 CH423_Write( CH423_DIG12 | BCD_decode_tab[12] | DOT_ );
	 CH423_Write( CH423_DIG13 | BCD_decode_tab[13] | DOT_ );
	 CH423_Write( CH423_DIG14 | BCD_decode_tab[14] | DOT_ );
	 CH423_Write( CH423_DIG15 | BCD_decode_tab[15] | DOT_ );
	 
	 mDelaymS( 255 );
	 mDelaymS( 255 );
	 mDelaymS( 255 );
	 mDelaymS( 255 );
}

// **************************************
// CH423的DEMO0
// **************************************
void CH423_Demo0( void )
{
 	 unsigned char input;
	 
 	 CH423_SetMode0();//启用IO扩展功能，IO7-IO0为输入，OC3-OC0为开漏输出
	 mDelaymS( 10 );
	 
	 do
	 {
	   	 input = CH423_IO_Input();//读CH423的IO7-IO0输入的数据
		 
	 	 if( input & 0x01 )//IO0输入1
	 	 {
		  	 CH423_OCH_Output( 0x00 );//OC15-OC8输出低电平
	 	  	 CH423_OCL_Output( 0x00 );//OC7-OC0输出低电平
	 	 }
	 	 else//IO0输入0
	 	 {
		  	 CH423_OCH_Output( 0xFF );//OC15-OC8不输出
		  	 CH423_OCL_Output( 0xFF );//OC7-OC0不输出
	 	 }
		 
		 mDelaymS( 255 );
     }
	 while(1);
}

// **************************************
// CH423的DEMO1
// **************************************
void CH423_Demo1( void )
{
 	 CH423_SetMode1();//启用IO扩展功能，IO7-IO0为输出，OC3-OC0为开漏输出
	 mDelaymS( 10 );
	 
	 while(1)
	 {
	  	 CH423_IO_Output( 0x55 );//IO6,IO4,IO2,IO0输出1，IO7,IO5,IO3,IO1输出0
		 mDelaymS( 255 );
		 
		 CH423_IO_Output( 0xAA );//IO6,IO4,IO2,IO0输出0，IO7,IO5,IO3,IO1输出1
		 mDelaymS( 255 );
		 
		 CH423_OCH_Output( 0x00 );//OC15-OC8输出低电平
		 CH423_OCL_Output( 0x00 );//OC7-OC0输出低电平
		 mDelaymS( 255 );
		 
		 CH423_OCH_Output( 0xFF );//OC15-OC8不输出
		 CH423_OCL_Output( 0xFF );//OC7-OC0不输出
		 mDelaymS( 255 );
	 }
}

// **************************************
// 主函数
// **************************************
void main( void )
{
    unsigned char demo = 0;
	
 	CH423_Init();//CH423初始化
	
	if( demo == 0 )
	{
     	CH423_Demo1();//输出模式Demo
    }
	else if( demo == 1 )
	{
     	CH423_Demo0();//输入模式Demo
	}
}


