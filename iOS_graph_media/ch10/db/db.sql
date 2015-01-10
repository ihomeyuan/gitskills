--
-- 转存表中的数据 `Category1`
--
INSERT INTO `Category1` (`_id`, `_name`) VALUES
(1, '操作系统'),
(2, '考试认证'),
(3, '网络/安全'),
(4, '服务器'),
(5, '新技术'),
(6, '移动开发'),
(7, '开发技术'),
(8, '数据库'),
(9, '其它'),
(10, '名校公开课'),
(11, '合作机构'),
(12, '直播公开课');

--
-- 转存表中的数据 `Category2`
--
INSERT INTO `Category2` (`_id`, `_name`, `_id1`) VALUES
(1, 'Linux', 1),
(2, 'Windows', 1),
(3, '软考', 2),
(4, '思科认证', 2),
(5, 'Linux认证', 2),
(6, 'H3C认证', 2),
(7, '华为认证', 2),
(8, '微软认证', 2),
(9, '项目管理', 2),
(10, '网络管理', 3),
(11, '路由交换', 3),
(12, '系统集成', 3),
(13, '安全技术', 3),
(14, '通信技术', 3),
(15, 'WinServer', 4),
(16, 'Exchange', 4),
(17, 'Lync', 4),
(18, 'SharePoint', 4),
(19, '虚拟化', 4),
(20, '云计算', 5),
(21, '大数据', 5),
(22, 'HTML5', 5),
(23, 'Android', 6),
(24, 'iOS', 6),
(25, 'Cocos2d-x', 6),
(26, 'WinPhone', 6),
(27, '移动设计', 6),
(28, 'Web开发', 7),
(29, 'C/C++', 7),
(30, '.Net', 7),
(31, 'Java', 7),
(32, 'Ruby', 7),
(33, 'Python', 7),
(34, '软件测试', 7),
(35, 'PHP', 7),
(36, 'Javascript', 7),
(37, '其他', 7),
(38, 'SQL Server', 8),
(39, 'Oracle', 8),
(40, 'MySQL', 8),
(41, '名校公开课', 9),
(42, '互联网', 9),
(43, 'Office', 9),
(44, '多媒体', 9),
(45, '设计', 9),
(46, 'SEO', 9);

--
-- 转存表中的数据 `Course`
--
INSERT INTO `Course` (`_id`, `_name`, `People_Number`, `Class_Hour`, `Charges`,`Teacher`, `Picture`, `URL`, `Description`, `_id2`) VALUES
(1, '畅谈：Android与iOS/WP8跨平台整合设计与开发', 58, 1, 0, '关东升 高焕堂 赵大羽','/android_iOS_WP8/wKioOVLI7MXTEEDxAACmwWBFjPg724.jpg', '/android_iOS_WP8/prog_index.m3u8', '俗语说：一箭双鵰、一石两鸟。意味着，基于正确的学习途径，可以驾轻就熟、事半功倍。本课程协助您贯通三个平台(Android、iOS和WP8)在终端应用(App)与云端平台(Platform)建置上，其幕后的共同架构设计、体验设计和开发技术。让您学习多把刷子来彩绘移动终端(一石多鸟)；此外， 也让您在大数据的云计算平台建构中，能顺利支持多种移动终端平台，而获得一劳多益的效果。议题：1. Java+C/Hbase雲平台架構設計2. 端雲整合創新架構設計3. 扁平化體驗設計4.跨平台&協同開發方法', 23),
(2, '基于Xcode原型驱动的iOS应用设计', 323, 1, 0, '关东升','/Xcode/wKioJlJWZsmBneehAAD4RC1ytxs156.jpg', '/Xcode/prog_index.m3u8', '基于Xcode原型驱动的iOS应用设计 Based on the Xcode prototype driven iOS application design你如何能够设计出满足用户需求的iOS应用呢？你如何设计和开发iOS应用呢？通过本课程能够学员了解使用Xcode进行原型设计，从原型设计入手进行iOS应用开发。适用于产品经理、项目经理、UI设计师、交互设计师等学员。', 24),
(3, 'iOS开发基础入门', 3418, 24, 0, '关东升','/ios_base/wKioJlJzXUeQZFdOAACoeilxoxU117.jpg', '/ios_base/prog_index.m3u8', '课程目标：【学习本课程可以掌握哪些技能】整套iOS系列课程，掌握iOSUI基础、基本UI控件、多视图程序开发，掌握iOS高级UI控件拾取器，掌握导航控制器与表视图，掌握iOS中多媒体API，触摸事件和手势，掌握Quartz以及iOS中动画的开发，能够做出简单的项目。适合对象：【什么样的人适合学习本课程】 对iOS开发感兴趣，计划从事iOS开发工作，个人创业者学习条件：【学习本课程需要具备什么样的基础知识和条件】具有一定的编程基础，了解Objective C，C，C++等编程技术', 24),
(4, 'iOS应用的扁平化改造', 375, 1, 0,'赵大羽', '/flat/wKioOVJWam-xeilsAACNiGZVwDw614.jpg', '/flat/prog_index.m3u8', '自从iOS 7发布以来，扁平化的设计和开发理念让我们所有的iOS开发工作者经受了很大的冲击。在今后的应用开发中我们是否应该做出改变，以迎合iOS 7的全新设计理念。同时，我们应该如何看待自己已有的应用产品，是否需要针对iOS 7进行扁平化改造。', 27),
(5, '如何成为移动应用用户体验设计师', 1381, 10, 0,'赵大羽', '/ue/wKioJlHeGHGC_680AABHWLNP10Q709.jpg', '/ue/prog_index.m3u8', '针对移动平台和移动产品，讲述成为一位用户体验设计师需要具备的能力和素质。这是一个专业跨度很大的职位，需要我们了解很多的知识、掌握很多的能力和技术、积累很多的经验和材料。因此，我们在进入这个行业或领域之前，应该对它--有个比较全面的了解。这套教材从应用对应用平台和移动产品的介绍开始，详细的讲述了移动应用用户体验设计的设计流程和主要的工作内容，为我们进入这一领域做好了准备，也为进一步的全面学习和工作尝试打下了基础。', 27),
(6, '苹果设计软件基础：Mac版Photoshop CS6入门', 3488, 20, 0,'赵大羽', '/Photoshop/wKioOVKhQAHgDq8vAACc7lRlJNI642.jpg', '/Photoshop/prog_index.m3u8', '这是一套针对图形设计初学者的入门教程。在从零开始掌握Photoshop软件应用的同时，了解初步的图形、图像设计、平面设计及网页和用户体验设计的初步方法。教学方法采用以三大功能体系（图层、通道和路径）为核心、以项目实例为驱动，并以专业设计的制图标准作为操作要求，由浅入深的使学员逐步迈入各类设计的专业殿堂。', 27);