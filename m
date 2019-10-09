Return-Path: <kasan-dev+bncBC5NVH6TWYJRBZ46SHWQKGQEGURRYHQ@googlegroups.com>
X-Original-To: lists+kasan-dev@lfdr.de
Delivered-To: lists+kasan-dev@lfdr.de
Received: from mail-qk1-f183.google.com (mail-qk1-f183.google.com [209.85.222.183])
	by mail.lfdr.de (Postfix) with ESMTPS id A52AED6048
	for <lists+kasan-dev@lfdr.de>; Mon, 14 Oct 2019 12:35:20 +0200 (CEST)
Received: by mail-qk1-f183.google.com with SMTP id n135sf16470354qke.23
        for <lists+kasan-dev@lfdr.de>; Mon, 14 Oct 2019 03:35:20 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1571049319; cv=pass;
        d=google.com; s=arc-20160816;
        b=h3kArjoKuJU0K3F04B1Rguej2U8rv05eZvlXr1SrFylKQY1a8VmFQNaOmxqJqZEZBy
         TTnTuDYFDi9RGFDIAkAFmmlaeyJU7q9iWP9aFYwLC7I3OpqI03A3IxalbEyJkxr+4Chx
         jvLo/HYxqBNDGr3gcuDYAStIjHfEK8ukgH4DziNtvSjVL+3ls4GzT1orJfiYI7hBPArY
         TMGmv5V6imydrCpztswfHMbuZbRPvKpoq+al1ZCct4AuTekqmQ98oGkozX0xpAz4R9/T
         l/uQyEMP9OOSvqbrVI3mNw9znp23OLwgqQk+LJFIS2UxTYqloOrEyLQSBT19cAQArxhK
         9boQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :ironport-phdr:ironport-sdr:ironport-sdr;
        bh=3DFZDWl0rnlvCCy3Dh1N0aOzNqvVP/6s9WoT+i8mPVQ=;
        b=v66VduIrxL05yy2/01dSizQ83w2b4Lb84j73cpuDxTXeyVCPdOBCbDTMuduCCRNSE4
         FFCPFjvs8aBzKpN0jpXuHV0NZ4jKCxj4E01xzdYBgg4gx7+XjF1hK0ilNbi0/A9+qHYY
         ADcf3cqChGCsjBZ0IhfeOVd3HejHeK9qmeODwEzJR01/q4ccy1VgBzfBQKjQ0WS8NiuU
         okkmTPGGTqYoQeejza8AhtWG/LhLqI/Pgh+8/tS9sDRB9f4E9TMmXu1+HRbxDEK5DRBX
         b09ddyahSGtJGjpHUVGP8FhNkJvegXlmE2GLPoyfFz8kl+URFXQDsXBDN56UQqBKZWvv
         pUzg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=k2ve4K34;
       spf=pass (google.com: best guess record for domain of baouchiy@listssympa-test.colorado.edu designates 128.138.129.156 as permitted sender) smtp.mailfrom=baouchiy@listssympa-test.colorado.edu;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:ironport-sdr:ironport-sdr:ironport-phdr:subject
         :to:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:sender:precedence:list-id
         :x-original-sender:x-original-authentication-results;
        bh=3DFZDWl0rnlvCCy3Dh1N0aOzNqvVP/6s9WoT+i8mPVQ=;
        b=GeJbABBLn71r4ypM/waqIkPOpi9sN25oKWc4FbvkZFQyXTKVe/zNcKV1a43DLe8RSo
         rrkHQ2iHYElj9UtBi/oJQT5xznWQVLCHg9Ij/5zzXlOG5S+YM6knxrh09gLbvxzhtMua
         048RdoiEdGVuDkIyrkW0yGaWWBMojaWi0AHAhVmPwMEet+OJZZ282lTggG1Sb6NBpVa6
         arfdinIxfTmAuMbxlMfuFEExvI24eIrcjMKJC9xDS7bXC+rhoa1gIU6ggjdAx6BpKOAC
         dyB+/lY77XOdE5iWHa5g0kYp/joipFglZHTWFwfk4WwiishZfvaUx3ydHAPl/1v6/uaW
         cV2g==
X-Gm-Message-State: APjAAAX7yP1iYvq//Sq0WsNaFa2CTDhKPkuwbED3qV2aCm6JkA5o3e/L
	Yvo+S2GyYK8E22M+ZMSvTfU=
X-Google-Smtp-Source: APXvYqzqq2REwLaIButL75DJEvz6Wn4DP6oZNgyYygKyCgJhMevhCEMOyBprEK9cfCDWSBPfw5nkgw==
X-Received: by 2002:a05:620a:8dc:: with SMTP id z28mr11166822qkz.83.1571049319611;
        Mon, 14 Oct 2019 03:35:19 -0700 (PDT)
X-BeenThere: kasan-dev@googlegroups.com
Received: by 2002:a37:4e04:: with SMTP id c4ls4086357qkb.3.gmail; Mon, 14 Oct
 2019 03:35:19 -0700 (PDT)
X-Received: by 2002:a05:620a:125c:: with SMTP id a28mr27934766qkl.195.1571049319449;
        Mon, 14 Oct 2019 03:35:19 -0700 (PDT)
Received: by 2002:a37:bcc7:0:0:0:0:0 with SMTP id m190msqkf;
        Sat, 12 Oct 2019 20:55:31 -0700 (PDT)
X-Received: by 2002:a0c:d787:: with SMTP id z7mr23925753qvi.152.1570938931258;
        Sat, 12 Oct 2019 20:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1570938931; cv=none;
        d=google.com; s=arc-20160816;
        b=H8dDSmgt4A2aTfNMwIeKbcCnDc374Mp0fbhjyHCGB3PQwjrQe63sIWHyh/rtwAae7O
         E4yDkSV4u3cIdIkps3V0rsBT70JwQaYp6xf6Xpymh5tj+k6g5JYvdDTGP1eDwuLcC5k+
         Nv+9ycCeje3Ip74foGQ1v4hQ3kqx7IymU/7XPn1S8teUqWrCGkFjDoLPFAXPd8VdXqxd
         XiWMSJsFj7LWms1MtvCgDO4Vrg3dhipMBKN+WaI01BK+4rfdwjRFI0b1J9Ri5h1ctlLz
         p0BxeeE3UdQpV7rCtpWsbxMFA3qLXupNFQ8tKroqLadq1htUc2nOOSK1dLbmt0wouA/C
         jNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:ironport-phdr
         :authentication-results-original:ironport-sdr:ironport-sdr
         :dkim-signature;
        bh=1W5q2468j7LBxf7IpTQ+peNYMM3xAgbZOJF/OAVpprc=;
        b=dyK5WxIyVrW8bpL4afB+P4SoT4xYIrlA1QCChJrRoPLj56VfoZ4mw/9eSlQVHFFmY9
         /77E3FntywVNhFjMlZx9RU19KKzE/9OjRqkhPt98oXKoFsdZHQYiqAWmbO+shdJTEhRp
         wIZ+Hs4yba5qMRQRS1tsdUwcr+pSmpHkwgEr3gruAcG7r6V02Gbi2CnLYjRa7KViSVwT
         AV7bWZOxmIdnLS486roK+DWRPbBOHkesdx4u6d784EmHrmxboYvMTmgxNnYN8VDmfrG9
         ETpXcJuTXqCZxgRNpNg0G0YbcWKV4nlQ7IQU31Xbg3iGVQxZE7Hzk4ORe5zOBxQlN+Az
         DlKw==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=k2ve4K34;
       spf=pass (google.com: best guess record for domain of baouchiy@listssympa-test.colorado.edu designates 128.138.129.156 as permitted sender) smtp.mailfrom=baouchiy@listssympa-test.colorado.edu;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: from listssympa-test.colorado.edu (listssympa-test.colorado.edu. [128.138.129.156])
        by gmr-mx.google.com with ESMTPS id c78si1141673qkb.7.2019.10.12.20.55.31
        for <kasan-dev@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2019 20:55:31 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of baouchiy@listssympa-test.colorado.edu designates 128.138.129.156 as permitted sender) client-ip=128.138.129.156;
Received: from listssympa-test.colorado.edu (localhost [127.0.0.1])
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/sympa) with ESMTPS id x9D3tOKY030833
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Oct 2019 21:55:24 -0600
Received: (from root@localhost)
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/submit) id x9D3tNEF030788;
	Sat, 12 Oct 2019 21:55:23 -0600
Received: from DM2SPR8EMB04.namprd03.prod.outlook.com (2603:10b6:a03:100::29) by
 BYAPR03MB4376.namprd03.prod.outlook.com with HTTPS via
 BYAPR08CA0016.NAMPRD08.PROD.OUTLOOK.COM; Wed, 9 Oct 2019 19:19:39 +0000
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 DM2SPR8EMB04.namprd03.prod.outlook.com (2a01:111:e400:50c7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 9 Oct
 2019 18:11:58 +0000
Received: from BY2NAM01FT039.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e42::203) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.26 via Frontend
 Transport; Wed, 9 Oct 2019 18:11:58 +0000
Received: from ipmx2.colorado.edu (128.138.128.232) by
 BY2NAM01FT039.mail.protection.outlook.com (10.152.68.115) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384)
 id 15.20.2347.16 via Frontend Transport; Wed, 9 Oct 2019 18:11:57 +0000
Received: from mx.colorado.edu ([128.138.128.150])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 11:19:04 -0600
Received: from vger.kernel.org ([209.132.180.67])  by mx.colorado.edu with ESMTP; 09
 Oct 2019 10:39:46 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand        id
 S1731686AbfJIQjp (ORCPT <rfc822;michael.gilroy@colorado.edu>);        Wed, 9
 Oct 2019 12:39:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42917 "EHLO       
 mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org       
 with ESMTP id S1731413AbfJIQjp (ORCPT       
 <rfc822;linux-kernel@vger.kernel.org>);        Wed, 9 Oct 2019 12:39:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so1299848pls.9        for
 <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:39:44 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b?
 ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])        by smtp.gmail.com with
 ESMTPSA id ce16sm2742759pjb.29.2019.10.09.09.39.42        (version=TLS1_3
 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Wed, 09 Oct 2019
 09:39:43 -0700 (PDT)
Received-SPF: None (protection.outlook.com: vger.kernel.org does not designate permitted
 sender hosts)
IronPort-SDR: mq8HBlXQkF4b1EopeAcgbEpUF3BduAxXRw2orkpiC6J9diahh6tanxPS2qtZgl7tNnHu08GxPt
 JMCD2AV2lGYb3IvOGJWY+ZyN0j4nj00dI=
IronPort-SDR: DBuY0tnWKCx/VTxVQmEW5VGCfTtm+ym5L0U/GdAp/rOjdB0wzlGCpDkVqTel7f3eJ1nb5otaQ7
 tg/cR5yJi0TUcx9ENXJ9L1mQCAHyH9x/s=
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
IronPort-PHdr: =?us-ascii?q?9a23=3A+Qg84Bf7ct08i8CF3dppPpwUlGMj4uimEi00z9?=
 =?us-ascii?q?8KlbtKb62//pPkYxWEt+s41QyBVNDB8PsBkOrf6f2+CiQLtIyMtHkSfZALTR?=
 =?us-ascii?q?IBgNUbk19FYobNQQWzZLaiY3k1Gc1DUBlu+HToeVMAQp6nOQSK+CDhiFxaUl?=
 =?us-ascii?q?23fUI9buSgAZPYjcm8y7Ku/M/YaFdSiTSwe750Jxit/wvLscxEhIZ5Ma8+x1?=
 =?us-ascii?q?7IrilEcvhbl35zKEjWlhnx4NvVntYru2wY87ppv5xFUKD3Oro1V6dZCzJ0Mm?=
 =?us-ascii?q?Zw/sDzsQiGUQzd7XwaTmgQjl9MCg7K8Rj1U8X6tS3mu+xhnTWANMvtQ70uHD?=
 =?us-ascii?q?mk5KBnSRnn20Jlf3ZxuCmfwoR6jPdanCKMvScjm47LTKCpL9dBVeCFWfYHVT?=
 =?us-ascii?q?dZXu9/fQlTXrGXdYQgHbY+JscA+tqYxRNG5VP2TUHkDrbskCFF2lytgfVl/t?=
 =?us-ascii?q?gxSFj6jFZ8BYoggETK9JKvGP4DXf/l/LSTwhfuQfN002ei6JT1TxYvo8C+Zr?=
 =?us-ascii?q?ZWUsyO62Y3EgOg7B3Y4cStd3vdnscu6HS05a1gX/iqlFQ1gFEygRLz++Q9hN?=
 =?us-ascii?q?HP29ov2H3Lsix33p8rfoeEGBZqbsC5MJcTjweUM49RUuByUyIwki8am7Y23P?=
 =?us-ascii?q?zzNGBCgNxvj1bSYPGpMJaYwB/4Df2wADAnlkxBWpiemi+tykOLjdLNeY6w0X?=
 =?us-ascii?q?NYl3RloN3utmwK9hn90eGXVdojrmmm6B+vigGUqdB4GyVW3eKTY9ZpivZ4sJ?=
 =?us-ascii?q?w3tXvHAj2smxz7jqW5TXkUwOyIy8DHZKT0g8aXZ7dWkz/hO48wudP8E9t/Ll?=
 =?us-ascii?q?BRWFbGx+Dk5IfC1EPnfZBx1a0EzLW80tiSbYxT7ubxSygK44Ap0AfvNTGA3I?=
 =?us-ascii?q?QiwmRaPmNXQEKojJmuYUHKBvbpIdaV31aPlBw0yvrLZLHaK6nDCifGvrXYeq?=
 =?us-ascii?q?l44FxX+Css3ehygvAcQvlJaLq7Egf3nvPHW0pqexzxwvzgDs16zJ9bQ2+UH6?=
 =?us-ascii?q?uFZbvbqkTbvLh9CvSQZIITpDf2IuQk4Pirt3IihFsBZvf2j54HLnu/GvN8Kk?=
 =?us-ascii?q?meJ3fgn4RJHWQLu18mRffxwB2ZUDFVbmqvRa90+DwhCYynAIuCDoCgibCMxm?=
 =?us-ascii?q?G6S7VZY2lHDhaHFnLl?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0FWAADME55dh0O0hNFlGgEBAQEBAQE?=
 =?us-ascii?q?BAQMBAQEBEQEBAQICAQEBAYF7gUtQcVQxKoQjg0oximGCDxRqgnCWYQMYMhM?=
 =?us-ascii?q?BAQEBAQEBAQEGAQEYDQcBAgEBAQGBAoM8glIjOBMCAQIJAQEBAwEBAQIBBQI?=
 =?us-ascii?q?BAQICEAEBAQoLCQgphTQMg0Y7LwEBAQEBAQEBAQEBAQEBAQEBAQEBARUCgQE?=
 =?us-ascii?q?GPgEBAQMBAg8RHQEbHQEDAgkBAQUFCwMKAgImAgIDHgIRAQUBHAYBDAYCAQE?=
 =?us-ascii?q?BHYMAAYJFAQMuAQ6jZ4EDPIsmgRUFAReCfgV3gVOBdQoZJw1jA4E8AgEGEno?=
 =?us-ascii?q?oinGBHYFYP4ERJ4I2NT6CGkcCAoF0gnmCXgSMYSCCM4ZzRJYXQQeCJWYEhh6?=
 =?us-ascii?q?KCYQCBhuNe4tFji2IIoIOiwuDewIKBwYPI4FGWoENDAgzGiNdEROCO1AQFIF?=
 =?us-ascii?q?PDBeDUIpzIjKBBgEBIY9yAQE?=
X-IPAS-Result: =?us-ascii?q?A0FWAADME55dh0O0hNFlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gUtQcVQxKoQjg0oximGCDxRqgnCWYQMYMhMBAQEBAQEBAQEGA?=
 =?us-ascii?q?QEYDQcBAgEBAQGBAoM8glIjOBMCAQIJAQEBAwEBAQIBBQIBAQICEAEBAQoLC?=
 =?us-ascii?q?QgphTQMg0Y7LwEBAQEBAQEBAQEBAQEBAQEBAQEBARUCgQEGPgEBAQMBAg8RH?=
 =?us-ascii?q?QEbHQEDAgkBAQUFCwMKAgImAgIDHgIRAQUBHAYBDAYCAQEBHYMAAYJFAQMuA?=
 =?us-ascii?q?Q6jZ4EDPIsmgRUFAReCfgV3gVOBdQoZJw1jA4E8AgEGEnooinGBHYFYP4ERJ?=
 =?us-ascii?q?4I2NT6CGkcCAoF0gnmCXgSMYSCCM4ZzRJYXQQeCJWYEhh6KCYQCBhuNe4tFj?=
 =?us-ascii?q?i2IIoIOiwuDewIKBwYPI4FGWoENDAgzGiNdEROCO1AQFIFPDBeDUIpzIjKBB?=
 =?us-ascii?q?gEBIY9yAQE?=
X-IronPort-AV: E=Sophos;i="5.67,277,1566885600";    d="scan'208";a="414186767"
X-Original-Recipients: migi9492@g.colorado.edu
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr4184536plq.27.1570639184433;       
 Wed, 09 Oct 2019 09:39:44 -0700 (PDT)
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To: "Dmitry Vyukov" <dvyukov@google.com>,
        "Eric Dumazet" <eric.dumazet@gmail.com>
Cc: "Will Deacon" <will@kernel.org>, "Marco Elver" <elver@google.com>,
        kasan-dev
 <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Andrey
 Konovalov" <andreyknvl@google.com>,
        "Alexander Potapenko"
 <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Paul
 Turner" <pjt@google.com>, "Daniel Axtens" <dja@axtens.net>,
        "Anatol Pomazau"
 <anatol@google.com>,
        "Andrea Parri" <parri.andrea@gmail.com>,
        "Alan Stern"
 <stern@rowland.harvard.edu>,
        "LKMM Maintainers -- Akira Yokosawa"
 <akiyks@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Boqun Feng"
 <boqun.feng@gmail.com>,
        "Daniel Lustig" <dlustig@nvidia.com>,
        "Jade Alglave"
 <j.alglave@ucl.ac.uk>,
        "Luc Maranget" <luc.maranget@inria.fr>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
 <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
 <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
 <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
From: "Eric Dumazet" <eric.dumazet@gmail.com>
Message-ID: <a47cfff6-e5b7-bf05-fe42-73d9545f3ffb@gmail.com>
Date: Wed, 9 Oct 2019 09:39:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-MS-Exchange-Organization-ExpirationStartTime: 09 Oct 2019 18:11:57.3880 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: bca646c4-81e7-465e-0a36-08d74ce42c31
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-Forefront-Antispam-Report: CIP:128.138.128.232;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:DM2SPR8EMB04;H:ipmx2.colorado.edu;FPR:;SPF:None;LANG:en;;SKIP:1;
X-MS-Exchange-Organization-AuthSource: BY2NAM01FT039.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: colorado.edu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bca646c4-81e7-465e-0a36-08d74ce42c31
X-MS-TrafficTypeDiagnostic: DM2SPR8EMB04:|DM2SPR8EMB04:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Organization-SCL: -1
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Microsoft-Antispam: BCL:0;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 18:11:57.1449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca646c4-81e7-465e-0a36-08d74ce42c31
X-MS-Exchange-CrossTenant-Id: 3ded8b1b-070d-4629-82e4-c0b019f46057
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3ded8b1b-070d-4629-82e4-c0b019f46057;Ip=[128.138.128.232];Helo=[ipmx2.colorado.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2SPR8EMB04
X-MS-Exchange-Transport-EndToEndLatency: 01:07:44.3286976
X-MS-Exchange-Processed-By-BccFoldering: 15.20.2347.014
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(750127)(520002050)(944506383)(944626516);
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Teutz47UC74Vcb+prY0tDCUcAcQkxgtzhvXfD8Ja82QNTQR+bJBxD4M/YDob?=
 =?us-ascii?Q?+g/D/2HX+h1oQnTsEnHRjm4cYgcfSWqIJXSnkYQSZ5PxqdfUfZyJzp56b0md?=
 =?us-ascii?Q?cD17MWFYzy/mcuNE4TOqNPqONQ7CGcUKXqm9GoBF9JZ2nZ9s/jG+6emozj7I?=
 =?us-ascii?Q?u3tWrOyawOzirVmC5+qhGIWdCpOkIYYY+5rZ0y9pCIiMA3xIxXYylexDfRfV?=
 =?us-ascii?Q?r067HUNsPfnJpj3F2RcdNGesagj5wqISdnLYyq3MijQYf0B3jDpRQ94OAmoc?=
 =?us-ascii?Q?TI3PxO7Oe3rRL2eR3Gc0ssh65oqD2St2l851EBUAaLTzynNJz/hO1JBUVp1I?=
 =?us-ascii?Q?d3Ylwvw6c60PM6WxmMG2FWoVuoUe8pTbDZPEdgg9Rz+XJQOgqwHFfoqyLyZG?=
 =?us-ascii?Q?jZ0yAm4RS/tJyaI1d7p+/n8RCCvVIHhb0PImYtz2XgdDm9NdBc/sYi/HVzIe?=
 =?us-ascii?Q?spLI85vwWTVyoxZCWXqEhCQKqeCPx832Nu4SsVM433HWspR3WxQEbhR8CWfH?=
 =?us-ascii?Q?u/osI8QWFqztqz0Fk0McYoLoqlj15uOSlJQiGKt077nfNEIlXpJA+IrzWF5b?=
 =?us-ascii?Q?FtwFnu0hDut18tDyN28F4lx/YUbDl5Mg5hvT4xRNQ4NS0SR1ohBeWvvh3M7k?=
 =?us-ascii?Q?LUZFIjLZeEkA3YTWtWKCwWmsNpW7+YH962ABGxH5vguTL31kDp36gzE9qAUO?=
 =?us-ascii?Q?KBJmpLnz0dPy8Zj5co88t6PwsEv4BxzfudOToyLw6hYZbr4QifeVdafyjjb7?=
 =?us-ascii?Q?iQlEy1F4AFVFL9pu0u/VbCNNtANAPufVtpTe/ccl6yeZjiy5mt61DCjcihh3?=
 =?us-ascii?Q?+2Rp5QgDMM73Kd1g31UjNUzW1doMS5fH6TNm8yQXzyYV1U88tk4UGCx3BTTY?=
 =?us-ascii?Q?NY9XznuNlehJE9oxLC2y4vHxY+0UjygjR1JqQ3R85HrO2aev9yNJdBy8jy0H?=
 =?us-ascii?Q?/m9tqyd566+8LiJmATszVrjtNO/haNNmWLBPe6BynMKz7Ez8wUO6L9TkdGHQ?=
 =?us-ascii?Q?4ozQ2o/9SlAdfa6nQF4L56aP5tQZa0TvHAjMxKGPU5KZa6FFoP/UVbM+WqC8?=
 =?us-ascii?Q?fD9U+DWemGMrLiRzhN0VvgbxHfBIGj4KSXa8/YI7SzCYCbAwZqzvufFzEMgc?=
 =?us-ascii?Q?9sUKwpcZYfIWsHZWA9T4KZqBghifFxrP+w=3D=3D?=
X-Original-Sender: eric.dumazet@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=neutral (body
 hash did not verify) header.i=@gmail.com header.s=20161025 header.b=k2ve4K34;
       spf=pass (google.com: best guess record for domain of
 baouchiy@listssympa-test.colorado.edu designates 128.138.129.156 as permitted
 sender) smtp.mailfrom=baouchiy@listssympa-test.colorado.edu;       dmarc=fail
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com



On 10/9/19 12:45 AM, Dmitry Vyukov wrote:
> On Sat, Oct 5, 2019 at 6:16 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Sat, Oct 5, 2019 at 2:58 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>>> This one is tricky. What I think we need to avoid is an onslaught of
>>>> patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
>>>> code being modified. My worry is that Joe Developer is eager to get their
>>>> first patch into the kernel, so runs this tool and starts spamming
>>>> maintainers with these things to the point that they start ignoring KCSAN
>>>> reports altogether because of the time they take up.
>>>>
>>>> I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
>>>> to have a comment describing the racy access, a bit like we do for memory
>>>> barriers. Another possibility would be to use atomic_t more widely if
>>>> there is genuine concurrency involved.
>>>>
>>>
>>> About READ_ONCE() and WRITE_ONCE(), we will probably need
>>>
>>> ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.
>>>
>>> WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.
>>
>> FWIW modern compilers can handle this if we tell them what we are trying to do:
>>
>> void foo(int *p, int x)
>> {
>>     x += __atomic_load_n(p, __ATOMIC_RELAXED);
>>     __atomic_store_n(p, x, __ATOMIC_RELAXED);
>> }
>>
>> $ clang test.c -c -O2 && objdump -d test.o
>>
>> 0000000000000000 <foo>:
>>    0: 01 37                add    %esi,(%rdi)
>>    2: c3                    retq
>>
>> We can have syntactic sugar on top of this of course.
> 
> An interesting precedent come up in another KCSAN bug report. Namely,
> it may be reasonable for a compiler to use different optimization
> heuristics for concurrent and non-concurrent code. Consider there are
> some legal code transformations, but it's unclear if they are
> profitable or not. It may be the case that for non-concurrent code the
> expectation is that it's a profitable transformation, but for
> concurrent code it is not. So that may be another reason to
> communicate to compiler what we want to do, rather than trying to
> trick and play against each other. I've added the concrete example
> here:
> https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
> 

Note that for bit fields, READ_ONCE() wont work.

Concrete example in net/xfrm/xfrm_algo.c:xfrm_probe_algs(void)
...
if (aalg_list[i].available != status)
        aalg_list[i].available = status;
...
if (ealg_list[i].available != status)
        ealg_list[i].available = status;
...
if (calg_list[i].available != status)
        calg_list[i].available = status;


-- 
You received this message because you are subscribed to the Google Groups "kasan-dev" group.
To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/a47cfff6-e5b7-bf05-fe42-73d9545f3ffb%40gmail.com.
