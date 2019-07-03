Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082295DE13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfGCGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 02:31:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:45227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCGbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562135495;
        bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
        h=X-UI-Sender-Class:Date:From:To;
        b=Br9zQK0IqW8Xzkrrrt7AWQd6aeS7lD5bdkmHBT7hiWyVZGLUbFQT8cLTmjsNYLnH9
         H2Cs3rF4f0USMjOaSzhi0iteT99ukQ8Tbh8DRoD/EE3q8+usSGrm7bXaxq0kRRmDbW
         Oat4QKcCIXb117uFs1bHR1Wf/s7mvIz2/+0rQUY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.183.112]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MUDXS-1i9TK11pRK-00QwtX; Wed, 03 Jul 2019 08:31:35 +0200
Date:   Wed, 3 Jul 2019 08:31:32 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Message-ID: <20190703063132.GA27292@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:AQMBZt/cS++AdckiN5SwFwqkuUR8cd+lHt0nOMAOU2Ylxk4imVX
 ZZnvsEWX16Ajm/b1kQAcRIhFGQbH78StHTFUVyu6L1nC7mazZEKH4wo3q1HvLUMe8AhMpHc
 T6JRfWNYFCII9X9792SE3PL0H199KECb2D6Wwv6KvGGc85oHbIc2L1RJMJNimHfycqy7ueU
 N+ywnOVQS6m7Y+jK2/8lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ghao0HUWzHw=:s3m676f3rTzwv6YsqyQVFW
 XAOmkiKdSvYClTnmfb8Zg0BFQM2snwyWlOODsuAOgjmp0Ag2HUAl0g5htNbRcuhB4cU5Ktp2P
 jIHqRuZ6K1YE857wM+pmyTqfqWqfal/NB2/uDqc82kwWZrFfTJ1vAVQmTXBZQzrUvp/Fv8Dtg
 Q1lbfwyip/uSm12dBkoNo1BGHNXQYqJRdBYN8TTh9x8xKFpw0rCymTShC18++QoQ/SkD9xCPK
 94Bs6mqpSDgDfNQNMM65cxXNGd5S+KJZvq/1nj1RAntdSUz3VGe7HX31Fu/BuLXCkFx023LFN
 TEEAb7MQv54P8x/PPrfga/1b/nnA+zdHcFF3oHr+pgp+Lzn99YhHh7BaK9aJvxwoSeoD7BeE3
 V4PaglIgxFNrcTBMpBIltXlImQHVb+KGVn1f/JQR723GvtAEvEkFGsBN5iqpVued8XqCilTkP
 TtSF2YP8Sb6ZWz55tm5JXNi+d79GQUW1Pxj8aizV4+hpLydn6J4hqeh/JO17TBw3YFDTxrQcs
 Ve2MagLGEAP1FStd20fm9Hjil2A8qpR6EfGoPTAOil9SeombqtktM1MQRKE80KG+R3rX+Q8Tf
 +lraDCPWxGm3yEQdD/U8ab8o+hnQrz8nf0M9ik/1DXaFPaZJ/Yg4w0OlEOqZsswxLxlDj/P3V
 2dmmDic40qMqGDu1Yjd9zG8RHeosqxaJpSTcuVvuBRypWUijz9lL33XVIXCZmh8IEvhVjehxP
 MBZMNVyx0FvpDeeTuJR6VPCAKOWRPMKBcnTFTOMSiVmGFUoNnzFcJmGA2Tzzdvou/f0hWdtzq
 p4PKwMFSMV+m7u/x2Fy+T7S4Vw3buWdgJjDGvpoMrYa639GS+d3gfpRaQ+LD2uCCnZdBb5YF1
 QOJXb3HcO5Dz3TllBLqnV98b1uromNUiFUP8l0k1fneK3hXvctXTBPdKek7tz5zBL+GfeSqHN
 W2SyCOA5u6F2kGxZJUuu9OLXc4fsATH4rZ3a8dpg7P5wJPOcMr0z+oIWwjXVMiHTQ/hMYeh6X
 SQzO+tqHPwE4I+scM9hFckXA6AreoAQVM+cS2xyyY46TZsNuiTZAlytOYFi5mn5el4sfP206Z
 DKqWWUR/NQ3CiiMmTu4kd08DzMUdm+mhQI+/gG66fvRJjBwOJu+GlRxV7gKied6DxcslfAN07
 Fjnvk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

