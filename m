Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CF26E3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfGSJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 05:43:41 -0400
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:46538 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfGSJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563529419; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=YLYJECgyWeEc/+ehczaKEdZrKvWgDvq4FlHiFPAL1VK5kVVLShigGUXcDMJgTINVfQ16lqrhDwKsduUvHxHJEBzBOXXumOUUR2g86W5Pq+dpfGoi9PpJjOU0gZhgRwB5n4ENqdlxRzp/btUp0lq7Jw7W4SSzgyEUCQRmJA4c/KvmaWtp6dqLhFXN0CoKpbpg+3px5qx/x5pCJKMV4WVNQZtyKIi5tHlhSPE/+b3U90MMWdXKMvpLEeJ6YdE9eLG1AYWAtpWLAzdyStlf1f1nl1rGJFVxDaUX1FDV6R0pmPJTGAITD6Srw/jxOo88L1kVCGvzJZ6O8kqjUnZ6FYhq8A==
X-YMail-OSG: lKp4JboVM1khZ8ozrMlwlc5zhMlnHt8MHijvbzHw4NIaCc5vUqGF.CT0X.3_Ife
 kKMT5Sbdk.f_94FIXfBEiKF99LUUg3LclR5etoQE.98Jf3xlCXxKC0vOfMlMmmyA7BOaLEJZmkdA
 EjJggk_0Vi7dNNhwoWjJ9WK7vQ5CZGBAoGCICWGFsiGZCE527NnZRDNB1enazcjwn2n6MFpZ35wB
 Ji53ncbHMotzrfXJarhak6hsl3qvLgttl2O2OaovE5aW8rUEG_C_Hk.iCwk0yMoxOcLktbqDib7G
 LMhP4QP2ryUNiN78lPzlouVgjYFt3NYZ8SRd1A8YEwp44TnrnwznKEBoJkII9ahA4BiBwHcV7945
 Z40ilcn8AgZYZuXcotsV5d9WxPpBcjDH5gV4qDvd6eIv2M4alEGAYhS8fBCklbdZKM3wtdb631y.
 3K4dn75gwcz6JpTHpQXt.ZvzxQcahUoWQLfBO_31hCOjF95s6oYRJaF5M1tOzqpgxNzA42ngXYY.
 j21dZWwSGYv4PCbws84aDSLHM74JGC6WJGX4CAEiw7FUnsqIJAb7YwqV_JUMXJyFeq88b.i1BLck
 AK6xDuJQ.IHGaXQNxj6kS8XC5qlEkzoi1sitp9BHXE0IC2teWeW87YSs1cfTzW7yXEuxvQEE1Ny2
 meix3Jy9.CDzbbqKbf4YrG3xqyS4CLL8HrsjOw_Y4uGCDgyOYrbETH2BCTUJXiy9mlJHtyvM_H5s
 0E3eIQInSXVYafiF6lXrRh2GMJxiaNys5inw7u2FbCNktjfDkIl7hK_P6VlHjO9XxDJyrcrfByrj
 Pw.9Shnou6XDsPngdcDlqx1XWUtVgRK1CxZXGcPgNH86F8q6PbSmlp_.36pxLpr6SUNf.MwQQaTd
 QDfKnuFJB_wFt4t5JCaKPQp6Os_luHCeV9NVHdihfbWlKnYEwH7XFLaU99oIGpafDkyy14XvyOJ3
 nEB6cDIao686xrT4TylQTQV3HJhCX50EpAN_KfywFf2RBOhRklFhq6_rqo6VLMQz.znjVGffq60J
 5IMdYzsH7IhzzE05_4B6rsRg350IYkmat7hTwA19SwPte8sZGUK8DDLKfeETztaBmWewlYj0mBWN
 aXqgYfEHOIx01Y2rbVj9DyJSsYW_P.t6jk64V6G7ryMtLIq9gkn_QflQWm73kDcYERoitU0B0UXv
 6LNUHjMB3iVGyeU5EVY6CmqeHg74UyytLrpxlKReE7ffVaHmlYimN8flgapvz1m7DkQc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jul 2019 09:43:39 +0000
Date:   Fri, 19 Jul 2019 09:43:39 +0000 (UTC)
From:   Aisha Gaddafi <gaddafia504@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <1287623732.2193770.1563529419098@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
