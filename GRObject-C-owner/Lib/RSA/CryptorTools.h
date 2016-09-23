//
//  CryptorTools.h
//  加密/解密工具
//
//  Created by 刘凡 on 15/4/26.
//  Copyright (c) 2015年 joyios. All rights reserved.
//

/* DES是对称密码算法，就是加密密钥能够从解密密钥中推算出来，反过来也成立。密钥较短，加密处理简单，加解密速度快，适用于加密大量数据的场合。
   RSA是非对称算法，加密密钥和解密密钥是不一样的，或者说不能由其中一个密钥推导出另一个密钥。密钥尺寸大，加解密速度慢，一般用来加密少量数据，比如DES的密钥。
   SHA1 和 MD5 是散列算法，将任意大小的数据映射到一个较小的、固定长度的唯一值。加密性强的散列一定是不可逆的，这就意味着通过散列结果，无法推出任何部分的原始信息
 
   AES：更快，兼容设备，安全级别高；
 
   SHA1：公钥后处理回传
 
   DES：本地数据，安全级别低
 
   RSA：非对称加密，有公钥和私钥
 
   MD5：防篡改
 */

#import <Foundation/Foundation.h>

///  加密工具类
///  提供RSA & AES & DES加密方法
@interface CryptorTools : NSObject

#pragma mark - DES 加密/解密
///  DES 加密
///
///  @param data      要加密的二进制数据
///  @param keyString 加密密钥
///  @param iv        IV向量
///
///  @return 加密后的二进制数据
+ (NSData *)DESEncryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData *)iv;

///  DES 加密字符串
///
///  @param string    要加密的字符串
///  @param keyString 加密密钥
///  @param iv        IV向量
///
///  @return 加密后的 BASE64 编码字符串
+ (NSString *)DESEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

///  DES 解密
///
///  @param data      要解密的二进制数据
///  @param keyString 解密密钥
///  @param iv        IV向量
///
///  @return 解密后的二进制数据
+ (NSData *)DESDecryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData *)iv;

///  DES 解密
///
///  @param string    要解密的 BASE64 编码字符串
///  @param keyString 解密密钥
///  @param iv        IV向量
///
///  @return 解密后的二进制数据
+ (NSString *)DESDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

#pragma mark - AES 加密/解密
///  AES 加密
///
///  @param data      要加密的二进制数据
///  @param keyString 加密密钥
///  @param iv        IV向量
///
///  @return 加密后的二进制数据
+ (NSData *)AESEncryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData *)iv;

///  AES 加密字符串
///
///  @param string    要加密的字符串
///  @param keyString 加密密钥
///  @param iv        IV向量
///
///  @return 加密后的 BASE64 编码字符串
+ (NSString *)AESEncryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

///  AES 解密
///
///  @param data      要解密的二进制数据
///  @param keyString 解密密钥
///  @param iv        IV向量
///
///  @return 解密后的二进制数据
+ (NSData *)AESDecryptData:(NSData *)data keyString:(NSString *)keyString iv:(NSData *)iv;

///  AES 解密
///
///  @param string    要解密的 BASE64 编码字符串
///  @param keyString 解密密钥
///  @param iv        IV向量
///
///  @return 解密后的二进制数据
+ (NSString *)AESDecryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv;

#pragma mark - RSA 加密/解密算法
///  加载公钥
///
///  @param filePath DER 公钥文件路径
- (void)loadPublicKeyWithFilePath:(NSString *)filePath;

///  加载私钥
///
///  @param filePath P12 私钥文件路径
///  @param password P12 密码
- (void)loadPrivateKey:(NSString *)filePath password:(NSString *)password;

///  RSA 加密数据
///
///  @param data 要加密的数据
///
///  @return 加密后的二进制数据
- (NSData *)RSAEncryptData:(NSData *)data;

///  RSA 加密字符串
///
///  @param string 要加密的字符串
///
///  @return 加密后的 BASE64 编码字符串
- (NSString *)RSAEncryptString:(NSString *)string;

///  RSA 解密数据
///
///  @param data 要解密的数据
///
///  @return 解密后的二进制数据
- (NSData *)RSADecryptData:(NSData *)data;

///  RSA 解密字符串
///
///  @param string 要解密的 BASE64 编码字符串
///
///  @return 解密后的字符串
- (NSString *)RSADecryptString:(NSString *)string;


- (NSString *)RSAEncryptString:(NSString *)string publicKey:(NSString *)publicKey;

+ (SecKeyRef)getPublicKeyRef;
+ (SecKeyRef)getPrivateKeyRef;

@end
