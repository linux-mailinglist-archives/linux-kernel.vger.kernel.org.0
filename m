Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C747E891C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbfJ2NNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:13:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17799 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbfJ2NNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:13:22 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x9TDD9H7008016
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 22:13:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x9TDD9H7008016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572354790;
        bh=DFJCAzizH4g10ADI9Rn27rAUxoPMKfPEwBoru1VHVxA=;
        h=From:Date:Subject:To:Cc:From;
        b=reO02uSbAHEiFpcpuoY5UJNhpn0kLh5Dj2QO71BSTK3k3pwXlQDuuAtgPWtz3zNIH
         NfPDCNagWGZDJY7oPXPs/Ps/0Pe/9cNig5HWLYrnpFiCtrm8o3GvrAT0ia1hlY9INT
         MvuDMWB4G82zqXlOGIX8Ism57sfinIjk5fYGTDVh7Fh5gosTU+HyPx4Au2c+g6lSal
         MNL6df8Hg+gKRg/3lAoTGrRZVUjMTMHQBuYEurTE2BvV4T95XenPDXPxgUliKdu//2
         XuCoraRjAn5byjZm3heDx9pTKoAEr5L+HIIaGnjJO8SuCAE+4mGgkxEE5OBbOS+Wua
         hMacoe4lqPsIQ==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id g14so2846820vkl.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:13:09 -0700 (PDT)
X-Gm-Message-State: APjAAAVJN7WFDAZlcBail+dSFwJmgpVXv510dG+rYUnJ9ZyBjz/Ijj8Z
        ZKbfIp6RoULmSDLi0y6YDOowzegJhzpJH+jO22U=
X-Google-Smtp-Source: APXvYqwSk5zozYtnYOUFkJt9J/Q7e7F+pJLQ82qQ4jKDaoYaSEYkYBruilGg08QiiaIIzCBMAtQodOEwwSp+lok8Esw=
X-Received: by 2002:a1f:4b05:: with SMTP id y5mr11132787vka.12.1572354788616;
 Tue, 29 Oct 2019 06:13:08 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 22:12:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Message-ID: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Subject: Warning message from 'make nsdeps' when namespace is lower cases
To:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I was playing with 'make nsdeps',
I saw a new warning.

If I rename USB_STORAGE to usb_storage,
I see 'warning: line 15: should usb_storage be a metavariable?'
Why? I think it comes from spatch.
It should be technically OK to use either upper or lower cases
for the namespace name.


Just apply the following, and try 'make nsdeps'.


diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
index 46635fa4a340..6f817d65c26b 100644
--- a/drivers/usb/storage/Makefile
+++ b/drivers/usb/storage/Makefile
@@ -8,7 +8,7 @@

 ccflags-y := -I $(srctree)/drivers/scsi

-ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
+ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage

 obj-$(CONFIG_USB_UAS)          += uas.o
 obj-$(CONFIG_USB_STORAGE)      += usb-storage.o










-- 
Best Regards
Masahiro Yamada
