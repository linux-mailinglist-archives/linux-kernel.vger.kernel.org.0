Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63412B1A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfE0J5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 05:57:43 -0400
Received: from sonic307-2.consmr.mail.ne1.yahoo.com ([66.163.190.121]:44468
        "EHLO sonic307-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbfE0J5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558951061; bh=QI8/VmbjVWYkTXliT6IkkpsE6DvYpw93p0qmwA+i8sY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=QT5Y5uekzEQ6+g/JPyBX7X5MoVPBLrnVw0XA7YgdMN42e/dpaofDRublh8We6emsj9HE/zMYxwCpsiJGoOJQdSGgM7FWa5H2qgXeaBpq+RVuNnLrVndS2JWCnZOslpYCa3aG9o+WjXWIJrjrUfvfdM6sjCVMsO/B6Li6sb+eg9lfpQxZ9sik58ekpfC3bng3caHHyK0TjQIzSq8z2XoOzgG5OUbUZtDKeL3BOiT+dXw72jFs41nohPW/TtipXMwGpx6sdc6K+wpCG4PyvqbSS9ljHPdKfauhQ4wnG9STbALdv+MyhaGrt32d9aWxkGEWFGv+zPjpjmJJNj/Ijv13Hw==
X-YMail-OSG: ZljiM.QVM1n01JL.fACrvXhlBWkb9B0JYuiFdeH03KmTa6UE0JcsN5BsX6LaDh2
 qkKGI.AVGXKCU0zx0CqO7IU2yCdKygqYcVs2dUJpeLMnkXcrEtPCLW3TTR7eedrPbJzyg9lrteJv
 _isG.iPuPcGkNhAwOPQTcKgUXgkArrGu8h0g9.U2h54oyYGYExLqUT7IDmJASTP.K73G9spWkvrd
 6O1DpZ.YE5vscZh2Kir36mIcpraVf4mP.ZfZXaYuZWGa1Dnvu0DepyZZP0P609BSKUEIFamPxHZ1
 zk6RuReYYjxerRsQBBuK1DiUw_ftsN4VAY5vWgIXlSOfCxceQz63_lUfnOkwPRC3oN4sH3UjR6Xr
 p8iiMEXAMvKuNezRmM0VhoNN9yhiBLf9RRJW00LevlcwTaCH6aiO.yk93Uk_eGzRvUh9VrYHqQYv
 Gvao9ydoyqKPGamCVmaFnjyHY9FdHKOWt1oH0muz7Mcpz0n_NdxZUQo9sKQTuV4P.lpUpu9YWtom
 kp.a_6ynXcX9FhCH.Hdvjg6KtW9hWgW6jIsDSL0.6Zg1TjRmsLK.Ta1P0rU4ovUffExp.4MZTZnA
 rBYLImwmW8lLYVwdosTRfgpoyLPOkOyTX11kTuLZ3gQhSmD7n41lUesuqo6_xAsgE5LYSEQBsWcS
 vqGsDUmp82eV.FzS3lUqgkCe1OfBkQ763mz2D4plUdJYyOjWYjNHmSXj.3eZPCRfsckr9X0lB8q4
 PUOLyi5BQsljIGSFih7Ip0vG6POWCfm2YPu9lSRyylAgnBr8evZeA7U8Vq1lKfveOaqBf1HoXHF9
 U1h__XIMeChALOKNKV4vQK8dtvAYsWsarl09KvA9_xMKl1L9Ha83iXrMr2It3TGvQRyqOOCPPrSQ
 P6t3rSgb9ZYMzxU6nEMuKlPhWU5cCRvuqlAAVzlX2bXvLGBTPuW4YlIC_rseTeNygxKn26B0OlTi
 DhFR3kFz66yuCqZFhWVCmjdESOx.A.991LUs7SKQHmMEBUiTV7LcBpAL3qUbBs6YChrONf2lrid.
 _D0T9I75SRz4Br7uYvPtAATfynlEIAYBReX.kiePVeyw1.l7oaR0S7oGls2Bt31J7mWSw8D138aU
 xPsGQgLed2LGL.7nTQTjBUvs4qBoXIDTCUKH_kA1lFNthssOkN8AMYYvn.aDZhkARkDq6D1Vrcvq
 kH8saiwT6R6aGHl5QyrRRS48EtSWNVhCXG._aO4eHobh9Y_QXFRkBRDWyIwOCzCxW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 27 May 2019 09:57:41 +0000
Date:   Mon, 27 May 2019 09:55:39 +0000 (UTC)
From:   Major Dennis Hornbeck <ee7@labourza.online>
Reply-To: Major Dennis Hornbeck <hornbeckmajordennis634@gmail.com>
Message-ID: <590479309.5421596.1558950939884@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <590479309.5421596.1558950939884.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am in the military unit here in Afghanistan, we have some amount of funds that we want to move out of the country. My partners and I need a good partner someone we can trust. It is risk free and legal. Reply to this email: hornbeckmajordennis634@gmail.com


Regards,
Major Dennis Hornbeck.
