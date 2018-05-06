//
//  Datas.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import Foundation

class Datas {
    class func getImageQuestion() -> [ImageQuestion] {
        return [
                        ImageQuestion("กีฬาฟุตซอล", ["กีฬาฟุตบอล", "กีฬาบาส", "กีฬาวอลเล่ย์บอล", "กีฬาฟุตซอล"]),
                        ImageQuestion("กีฬาฟุตบอล", ["กีฬาฟุตบอล", "กีฬาบาส", "กีฬาวอลเล่ย์บอล", "กีฬาฟุตซอล"]),
                        ImageQuestion("ดวงอาทิตย์ขึ้น", ["ดวงอาทิตย์ขึ้น", "อากาศฝนตก", "น้ำท่วม", "น้ำตก"]),
                        ImageQuestion("ตลาดสด", ["ห้างสรรพสินค้า", "ตลาดสด", "ตลาดน้ำ", "ขายของออนไลน์"]),
                        ImageQuestion("ตำรวจ", ["ทหาร", "ตำรวจ", "ลูกเสือ", "รปภ"]),
                        ImageQuestion("ทหาร", ["นายก", "ผู้ประกาศข่าว", "ทหาร", "นักแต่งเพลง"]),
                        ImageQuestion("ทะเล", ["ทะเล", "ภูเขา", "น้ำตก", "บึง"]),
                        ImageQuestion("นาเกลือ", ["นาข้าว", "สวนผัก", "สวนผลไม้", "นาเกลือ"]),
                        ImageQuestion("นาข้าว", ["นาเกลือ", "สวนผัก", "สวนผลไม้", "นาข้าว"]),
                        ImageQuestion("น้ำท่วม", ["ไฟไหม้", "น้ำท่วม", "อากาศแห้ง", "ฟ้าผ่า"]),
                        ImageQuestion("ป่ากงกาง", ["ป่ากงกาง", "ป่าไม้", "ป่าดิบชื้น", "ป่าหญ้า"]),
                        ImageQuestion("ป่าไม้", ["ป่ากงกาง", "ป่าไม้", "ป่าดิบชื้น", "ป่าหญ้า"]),
                        ImageQuestion("พยาบาล", ["นางฟ้า", "ครู", "พยาบาล", "ตำรวจ"]),
                        ImageQuestion("ภูเขา", ["ทะเล", "ภูเขา", "น้ำตก", "บึง"]),
                        ImageQuestion("แม่น้ำ", ["ทะเล", "ภูเขา", "น้ำตก", "แม่น้ำ"]),
                        ImageQuestion("แมว", ["นก", "แมว", "สุนัข", "ลิง"]),
                        ImageQuestion("โรงเรียน", ["โรงเรียน", "โรงบาล", "โรงพัก", "โรงงาน"]),
                        ImageQuestion("เสือดำ", ["เสือดำ", "เปรมชัย", "แมวน้ำ", "สิงโต"]),
                        ImageQuestion("หมานอน", ["หมานั่ง", "หมานอน", "หมาหอน", "หมากระโดด"]),
                        ImageQuestion("หมานั่ง", ["หมานั่ง", "หมานอน", "หมาหอน", "หมากระโดด"]),
                        ImageQuestion("ตลาดสด", ["ห้างสรรพสินค้า", "ตลาดสด", "ตลาดน้ำ", "ขายของออนไลน์"]),
                        ImageQuestion("อนุสาวรีย์ชัยสมรภูมิ",["ตลาดจตุจักร","อนุสาวรีย์ชัยสมรภูมิ","ตลาดน้ำดำเนินสะดวก"]),
                        ImageQuestion("นักเรียน", ["นักเรียน", "นักศึกษา", "นักการภารโรง", "นักวิชาการ"]),
                        ImageQuestion("วัดพระแก้ว",["สวนสัตว์เปิดเขาเขียว","วัดสายตาประกอบแว่น","วัดพระแก้ว"]),
                        ImageQuestion("แอร์โฮสเตส", ["นักบิน", "แอร์โฮสเตส", "นางฟ้า", "พนักงานทำความสะอาด"]),
                        ImageQuestion("กล้วย", ["องุ่น", "ส้ม", "มะละกอ", "กล้วย"]),
                        ImageQuestion("ทุเรียน", ["องุ่น", "ทุเรียน", "มะละกอ", "กล้วย"]),
                        ImageQuestion("ส้ม", ["องุ่น", "ทุเรียน", "มะละกอ", "ส้ม"]),
                        ImageQuestion("นักศึกษา", ["นางฟ้า", "นักเรียน", "นักศึกษา", "แอร์โฮสเตส"]),
                        ImageQuestion("สะพาน", ["สะพาน", "บ้าน","อาคาร", "โรงแรม"]),
                        ImageQuestion("เด็ก", ["ผู้ใหญ่", "เด็ก","แมว", "หมา"]),
                        ImageQuestion("เด็กผู้ชาย", ["เด็กผู้หญิง", "เด็กผู้ชาย","ผู้ชาย", "ผู้หญิง"]),
                        ImageQuestion("เด็กผู้หญิง", ["เด็กผู้หญิง", "เด็กผู้ชาย","ผู้ชาย", "ผู้หญิง"]),
                        ImageQuestion("ห้องน้ำ", ["ห้องครัว", "ห้องน้ำ","ห้องนอน", "ห้องเก็บของ"]),
                        ImageQuestion("ห้องครัว", ["ห้องครัว", "ห้องน้ำ","ห้องนอน", "ห้องเก็บของ"]),
                        ImageQuestion("ช่างตัดผม", ["ช่างไฟฟ้า", "ช่างประปา","ช่างซ่อมรถ", "ช่างไม่รู้อะไรบ้างเลย"]),
                        ImageQuestion("ช่างตัดไฟ", ["ช่างไฟฟ้า", "ช่างประปา","ช่างซ่อมรถ", "ช่างไม่รู้อะไรบ้างเลย"]),
                        ImageQuestion("ช่างซ่อมรถ", ["ช่างไฟฟ้า", "ช่างประปา","ช่างซ่อมรถ", "ช่างไม่รู้อะไรบ้างเลย"]),
                        ImageQuestion("ช่างประปา", ["ช่างไฟฟ้า", "ช่างประปา","ช่างซ่อมรถ", "ช่างไม่รู้อะไรบ้างเลย"]),
                        ImageQuestion("บุรุษไปรษณี", ["ช่างไฟฟ้า", "ช่างประปา","ช่างซ่อมรถ", "บุรุษไปรษณี"]),
                        ImageQuestion("ควาย", ["ควาย", "แมว","หมี", "วัว"]),
                        ImageQuestion("วัว", ["ควาย", "แมว","หมี", "วัว"]),
                        ImageQuestion("ไก่", ["ไก่", "แมว","หมา", "ลิง"]),
                        ImageQuestion("แพะ", ["แกะ", "แพะ","หมา", "แมว"]),
                        ImageQuestion("แกะ", ["แกะ", "แพะ","หมา", "แมว"]),
                        ImageQuestion("ม้า", ["แกะ", "แพะ","ม้า", "แมว"]),
                        ImageQuestion("หมี", ["ควาย", "แมว","หมี", "วัว"]),
                        ImageQuestion("กวาง", ["ควาย", "กวาง","หมี", "วัว"]),
                        ImageQuestion("ปู", ["กุ้ง", "ปู","กั้ง", "กบ"]),
                        ImageQuestion("จระเข้", ["จระเข้", "ตัวเงินตัวทอง","กิ่งก้า", "จิ้งเหลน"]),
                        ImageQuestion("หมึก", ["หมึก", "หญ้าทะเล","พุ่มไม้", "กุ้ง"]),
                        ImageQuestion("ม้าน้ำ", ["ม้า", "ม้าหมุน","ม้าน้ำ", "ม้ามี้"]),
                        ImageQuestion("แมวน้ำ", ["แมว", "แมวน้ำ","สิงโตทะเล", "ฮิปโป"]),
                        ImageQuestion("ฉลาม", ["ฉลาม", "โลมา","วาฬ", "ปิงทะเล"]),
                        ImageQuestion("ปลาดาว", ["ปลาหมึก", "หอย","ปะการัง", "ปลาดาว"]),
                        ImageQuestion("ค้างคาว", ["หนู", "ค้างคาว","หนู", "กระรอก"]),
                        ImageQuestion("ผึ้ง", ["ต่อ", "แตน","ผึ้ง", "ผีเสื้อ"]),
                        ImageQuestion("นก", ["นก", "ค้างคาว","กระรอก", "กระแต"]),
                        ImageQuestion("ผีเสื้อ", ["นก", "ค้างคาว","ผีเสื้อ", "ใบไม้"]),
                        ImageQuestion("แมลงปอ", ["แมลงปอ", "แมลงป่อง","แมลงภู่", "แมลงวัน"]),
                        ImageQuestion("นกอินทรี", ["เหยี่ยว", "นกอนินทรี","นกอินทรี", "นกพิราบ"]),
                        ImageQuestion("นกกระจอกเทศ", ["นกกระจอกเทศ", "นกเพนกวิน","นกกระจอก", "นกพิราบ"]),
                        ImageQuestion("นกฮููก", ["เหยี่ยว", "นกอินทรี","นกกระจอก", "นกพิราบ"]),
                        ImageQuestion("ต่อยมวย", ["ต่อยมมวย", "เต้น","เตะบอล", "ชู้ตบาส"]),
                        ImageQuestion("ชู้ตบาส", ["เลี้ยงบอล", "เลี้ยงบาส","เตะบอล", "ชู้ตบาส"]),
                        ImageQuestion("ยิงธนู", ["ยิงปืน", "ยิงธนู", "ยิงหนังสะติ๊ก", "ยิงลูกแก้ว"]),
                        ImageQuestion("วาดรูป", ["วาดรูป", "แต่งเพลง","ดูหนัง", "ฟังเพลง"])
        ]
    }
}