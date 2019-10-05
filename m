Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBECC9F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfJEM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 08:29:46 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51212 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJEM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 08:29:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 6D6FD3F9CA;
        Sat,  5 Oct 2019 14:29:43 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=eXiaWehj;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZvVhr-XueHu5; Sat,  5 Oct 2019 14:29:42 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id CBC323F9B6;
        Sat,  5 Oct 2019 14:29:41 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 3C13836014C;
        Sat,  5 Oct 2019 14:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570278581; bh=/gR1HwYFIIqFRwJfuDUBbZYDELbnZuayqLuZ9ZZV6b8=;
        h=To:Cc:From:Subject:Date:From;
        b=eXiaWehju1eFoQiw6YFkzE3Wmwwf94Hlc6AH0FmGBSkirtIB4zPrIT4711WNqm61c
         zLQR7fVqctWxaw5m5+KLmGCTlXb+NtTUOluIzaZHcnKC0g7doLKFfAY36yXpHHlhFy
         GMGQLB6uVLjwXeAi8tG3pcQa8gRrtNHlA6wzs9e0=
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: hmm pud-entry callback locking?
Organization: VMware Inc.
Message-ID: <4d25d751-d03a-29c6-950b-cafe8d201784@shipmail.org>
Date:   Sat, 5 Oct 2019 14:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jerome,

I was asked by Kirill to try to unify the pagewalk pud_entry and 
pmd_entry callbacks. The only user of the pagewalk pud-entry is 
currently hmm.

But the pagewalk code call pud_entry only for huge puds with the 
page-table lock held, whereas the hmm callback appears to assume it gets 
called unconditionally without the page-table lock held?

Could you shed some light into this?

Thanks,
Thomas


