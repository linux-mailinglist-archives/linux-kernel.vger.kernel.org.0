Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3ED4173E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391830AbfFKVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 17:54:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35197 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391563AbfFKVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:54:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so18293777edr.2;
        Tue, 11 Jun 2019 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHhMjd1fNN7IkriGi8xv0Blych3KQHIWLAG6ekYhHaU=;
        b=e8LUQDA0ucs+NpZtWxD/LJWddlKnLuSOXGX6Y6zjx9R6JyJVLVfwfq86T9reM2rrNC
         2ohulDkuA89z/5oTEbIIr9mwlhpN9nJVXWdYYlenHvLRdz5rht0bdymhI8/yu3D2ktL0
         x1kg/JxPRzw6LW0cKKHEfePtwxbsBcPSNnpvEDZESa4f0VcxHYpV+GZzFnYHmEd+CC1h
         2+ftkUN8WQ/VWse3L/CA+lPsPLR3RWNGM7Z9b4i3KHAs182b//CbCV5mkwllk1JR83ld
         ZNyNEbE5/CjvgRgvFNHxBwDLdcCHj3rzO8h6nvfFkoEkXaH2JKjt2QZFajDfMOgYN8cZ
         1x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHhMjd1fNN7IkriGi8xv0Blych3KQHIWLAG6ekYhHaU=;
        b=LTEwKDZGvA2CH79BZWk3BlZ/WKd3LgSQ19EIMUYnlAgZSt/ek0RiyhuVvM0upx3xC/
         EiTGt7zOTyZ31aZWPtTYQIPUoEYI/mKdUo0/1/S5QZM0cLPlqAfXkNMpnGFZwSjwTPIK
         +QtawMvcjOQggtMFp9CE0Eb2IL9CPlotoWmiQMrOtxF9NuTN8eTL/5xWWVyxwqtvzYMo
         c1u9pYllRfmMSqDLnnCRJO6jU2rYYKUhGv+JYbZ4b6e+koMhMsPVatpmPj+P081K0Lx8
         QA83zE8DVqQFKPYweUV+/s7hdsfGXS9BEqs5EaniUrsHbjEbOilGOENXWdRYO46ZDQ7+
         0zvA==
X-Gm-Message-State: APjAAAXAb1Y36UsEjmhRscQUMKwFvBwyrve7364gYw4eBoqzHe79/C5/
        ksr8vdZ6pNWqi/TkKdlyYes=
X-Google-Smtp-Source: APXvYqxa6B3yBQfXiX0KGyiJzxI3jbaWqHZPyTOBf9DKR2bvaQfBCmkV0iVTPijvFqtSl/LUQm5zqQ==
X-Received: by 2002:a50:a784:: with SMTP id i4mr14433341edc.3.1560290069503;
        Tue, 11 Jun 2019 14:54:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 23sm2498119eji.42.2019.06.11.14.54.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 14:54:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ARM: dts: Cygnus: Fix most DTC W=1 warnings
Date:   Tue, 11 Jun 2019 14:54:19 -0700
Message-Id: <20190611215419.10109-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190528230134.27007-3-f.fainelli@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com> <20190528230134.27007-3-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 16:01:29 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Fix the bulk of the unit_address_vs_reg warnings and unnecessary
> \#address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
