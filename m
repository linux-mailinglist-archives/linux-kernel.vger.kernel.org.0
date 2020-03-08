Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E339E17D0EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 03:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHCbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 21:31:02 -0500
Received: from sonic317-3.consmr.mail.bf2.yahoo.com ([74.6.129.186]:37527 "EHLO
        sonic317-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgCHCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583634660; bh=VxFSqOLnoyhxZXWK73TPGK3hr8yutZ4yWmLQa/jSY/I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=G6JgwleEsrOK61idFSNxC+SFrgUPkMRy6s4Af71gJlq0FgLoBMKXt5Wfy/zQtmZGM51vlKPYui8WQYNEFu36tKvmA9IpTm4gfOClT6/sMxn4yYEDpxHIBIr+jlOnIb5XJStS7yZ3sSjn9iqD7z+iWF2/KJrIoO2XIPp9zARhrbykfdrO1h0YnQ7Z1XTUbTuvpPexxuXeJtogNAaWXsOfZERnaLDZY4T3uob0foMvFCntfDcWlbViS8stpLPSN+dBL6xqIVjqab/9f8qUEGOrbUlX3MvkqrHM15a5oB7TLSYkrHDH4J8Bjf2QJyYBHvkEaxXvvBCuwhGoLcEtzr8MdA==
X-YMail-OSG: 3mk97JQVM1mjCoeMX4cD00DNZw7rnWtXLocsTsOcysufTwbX.MuQJeSLdL8Wp11
 b0NXDpc1dtGCjyO9.6mOVPM4D3BhRluc8nPSA1IVzUCkMlrtx7m87.yN9.WfnGRZQpdl3Lw62rwQ
 EvMfUBo7Sd6yy9HXo3ToNbIwNsXp4Yg.FTQFgX1plkGtozZbBIL9q8QS82iDhtek7cTFSHrkEHCh
 _0tqKxbyFFtjgtO87qoYzYYeDaq.ya_VNdKcP0_rL03u1H4r2KZVpnSnTkES0a5rmFCewY6O9CPU
 LJOqBjenlQ37e4isHPWgJ.11a80AJEj087fh4gy3n9pAC.BygAbmEIX3ilE.YVu_uDQ5bdcNkYvy
 JsdMvKPgzJyHfXC5KlSbzPRCGuGwKm.TqaO6O3DodqUfOjNrmVa9ptFk7kszZ5dzCkiNWRH3RUit
 AA9px1LLH.iJASvC0tOjUbDxDHg2qbXQZPVUNOlqj9_yLwmh9q18yrvYPJFyNdPg8WsbanCB2QLM
 rP1PJn0ZQU9A.KyrCyPIU4W2IRQxYzGI4f1NXDOyX3zLqeYbNfsqHolSkPsM5JBhcYkuQmB1zeds
 9WsqugDtgEGdWXYBAvyUr.lTGanm6j1MrXD2yayqbEwhuOZQCHAReYTm6SFS5WoBfBLx4Kph1GWH
 bLr4DerK16IKKLUafO0YQZ2HQw31nudoGPS5AyTku5lWEkllDsBji3ZDAFSJG7oHZC_gM9UO_99A
 8_VrBc7u1G8gXJ3fHuDrQaX66l6N.9gF4zHIOcFBxlvGRJHoo3Qi0z.BeOHRBR1ZnQTXoVqIWzoT
 JCv3Jt32aHN5tq9A5rVl0ejGLsBHTuZiyMyycueYNQnrzRkmKx3OfyWjKy9BNhFPu.V637DHmC8p
 3EFOxGs_JANBIO_xjp1Nh7HiNeawOTXqe14nNwsf6HTeESkXBn11aTTJTZ9oGzrq72fEpBYfEGKR
 C_ujoMPdlNcMdMTbQrDvc7XffqEB0IQhhE9Tj753GpYELEhXEFmrR9yTdNM7wWZ11RKbVg8ilHRM
 Rq1VjGjBZ_fmTG0UKqFwFafm86AVRqetDU75b7Fs_X8JN.gbK4pmcw6brgNsHro.U.HZ6unl9qDi
 hnYbQxNMHn.xlwN.FeFI93Pe0zjOUIzohBFaAaGsU8LZ2WqKQp5V0YK_X_4FqkOFKczmkM_yjPnc
 TcTvRaNltf89EiLBs9TadD7NvYy7ObPpq6umHyPQmRuMk5TA0gFdGkdTSsW28aw30YAwDodstPUN
 ITMQeD5fBVJPsqeFojrqo1J.D5DoZNlOOHS5avxc6GhmBpDrRiGq5xMbeV6cq9GBkKJLeOvbMOnb
 HMY8kE752mca7gozrTPWkpgiQmTJgGsJ2iA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sun, 8 Mar 2020 02:31:00 +0000
Date:   Sun, 8 Mar 2020 02:29:00 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <ss31@gbaxm.com>
Reply-To: maurhinck6@gmail.com
Message-ID: <181840190.971354.1583634540242@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <181840190.971354.1583634540242.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36 OPR/66.0.3515.115
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck6@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.
