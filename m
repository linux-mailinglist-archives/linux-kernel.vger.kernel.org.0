Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08535FC69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGDRVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 13:21:47 -0400
Received: from sonic312-21.consmr.mail.bf2.yahoo.com ([74.6.128.83]:38279 "EHLO
        sonic312-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727174AbfGDRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562260906; bh=rv+XavkjGt5bQhyBtWMZ3k04LCi26O+Ai7ujWr0MjEU=; h=Date:From:Reply-To:Subject:From:Subject; b=FRY3GC+jVi+t9dDUwT+CR/KWnv1h4QDqG2QBBQL98f/IVlJM6gAyT9mCbNZt3chA5ieZQ4a2aLhiDvDFl0+AGgUKiCya3HCn/B0kBLnddHlPEzV9+S9gxhKkp9JNkIYFFwZ2XmsJx1iirszPWYuBIGKfYqyGKAVxgUAcd3to+ZRFm6rCrMmeRuvzbPZp4Ih1jtxBnJRjT9kN4Yd00H45ZlKxsGZ89HGZdhHi44BQbUrTOHH4oGO6DhldSnvt3kMrk4Vk/kdO9I0SzAGKwEo9vBwxex7F3rGZAv7QmYzcEo08jlkF61LM4PJKU5+5yprsC8U1/48kBE8t4l60JOZoQQ==
X-YMail-OSG: JkVdZ5QVM1m51Etf.ZDMAhom1hSIJUWZt6zby664FUuj9rsWo2UVYUHTen8CtJa
 z1QlcCTVWl5T00v6AWnSf1mSphDra69g9FihOfExg_54w_gwSjoZJ1wqW9zxpFNknQXu98O4tNCQ
 kyeJ.qf4tqeJ4W6IZ7vdrQrD08_xiLNxFKZEm_fldKwmgAT221a8mpStEnl2__xHXnGHsAKbrNH_
 b2qtUM8q460amvD.RtKMFGx_UUfa5HJD9YM7GRNMyZ5xodIpL44jeWZGWQqJzroxWlUtZxE58ie0
 uy5vBQLPSZ_vgxEzJKME4mJMmR6SR5YfiQqB18ds6f1YtdelSzuXhUVm60_2k4MUulYxb4DXt_OW
 f0K1YtO2HRN_8UOHYBEqGwc1ZKN6YtIdmjBAHemso0NaiOmUtGoqIoh.9M1URDXYzQt7LEB6g0JJ
 nz8OMlobFl6JLg8fYr4c.4qCYHT6Vi0lIPzWFT7nHVPDELgf7C58XJR4isjAqAg5vCM9H4.Ecqsn
 FWT7BsCh3nIHf7Fu20RxtfDdH7i6BspRMucK8t8cW4_jNIIfF0sIXcqUw4P2B82wpvTFq09MZmfe
 zqrnW1PTbvoWPu7Wt4ZhHKGuFGwmkM86EGZ3Nfbt9ZzXD5WgN8ieMIJMSvefizqHNxS8uXYOgQtv
 TJAvj.Aib_9ay0mFMATdfihUTapon21dhH.aCvc0tqvBbZezHQXwjingKA9xa_kOvJPf.hS_VHxt
 cQDbwTFStajdB0Acy82Vy80QI0JNPItfcc7S39wlb5CHmZe5S_2Too9nURbqA8.3gYzCmDIUXQWH
 pc5o_kg3TN472ax4uCGqr7VgqHeqyHSsB983.AFNCx0D6HOArZ4BxHwc3uiegjZ4J0Bf4SSYrdps
 TGNo2T2lmLBY.tANaWOUUxPU.Ir7bySNTJ0f53Y_hpGYHoEvH03mqHLUfGt6Y8dZnybrHQ9JkzRL
 GzIdu6aw.0OP2re3JBFrl7EQ4b92dBiNRUkciQUPvi1cvTXIksMERDbPupZPSZVl.Kuln9iMaiU0
 DBHjoqkMJ2x29.ojN8UxI64e6UUyx5kOFkWoXMQtQsrUUlMYXKaaIA6O_008q7tYb32boNLLVd0u
 JDlkpOufrSE8Hzx4eL9Qm2SHPvQ01c1Rr9qnbhsMFCxu.czVK1aVTQy_62MaSyN10KpVAgMhWLOY
 RnWxfGQ2VmesdxJcEUGL6zG_0oeYkSOeiL8OnTjksEMN7O9newwKcAaJHZw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 4 Jul 2019 17:21:46 +0000
Date:   Thu, 4 Jul 2019 17:21:44 +0000 (UTC)
From:   b18385@frontiernet.net
Reply-To: chrisben697@gmail.com
Message-ID: <639162046.1949287.1562260904521@mail.yahoo.com>
Subject: hi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



How are you? I hope you're fine, I sent you a message earlier, but there was no response from you, did you receive my first email to you? I urge you to confirm receipt of my previous letter and contact me by email
