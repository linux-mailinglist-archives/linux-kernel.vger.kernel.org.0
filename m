Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A732107288
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 13:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfKVMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 07:54:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44193 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKVMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:54:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so4387234lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 04:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG50UWayPIvArcjGQie+7s9WHqHtX+folJX7ygZx60Q=;
        b=JJ3KRgl/mgm/zPoJWzx69dPATcieIl6pzOnf0+t2sIUivFjhW6SNKkL9mLhZy+F6wY
         N/xVg8z4+oAzxmiwd844eE9RZokPf36VKp5ur0d/kb9mW96kZEM0M3losANKfIUTiubE
         53ZA7Tuy4Q2yz5GCBK5FNKuAriXTVjtdSHG8lwPT8HJBZCaZplWV5t1GR2dN5I+2YjYk
         +TkZjJc98g1lP5tj/3+c8EN1p4f3DKqpn54kAIEu3tP43ogOcjSI9+EkInz5l4IuGJdp
         +b2qE5ZiNtwEhvP1T3w/XFlxvhSkmBzBGr29rg2uw40Lt1Kw/xJ+BOx9ALaTAqWWfM6/
         r5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG50UWayPIvArcjGQie+7s9WHqHtX+folJX7ygZx60Q=;
        b=HL0sjdOn1Pwy09KAA67tGmFCYiTYF68lxP//z1Sl6+7nQSWO1GuTQhnh55CLXiiXO9
         9KcQpNHT4NKR5Fg1MnYNypd9r/SGbgBkRtusknF+rPD5nSYS0xMKgyidJLoYFOLBbL+s
         DjuZv0BqxfYzR+/vHPC/Mum86+17snMB7AlCTY/Fca//iCuTqGBVGGqvBje8MhHSKWaB
         Mq1ap0jBuSFf4fhQkxmM5kUpz46jtZMaUGw2n392qyAH+a+cszV1k3pndvsYfguIg3Gl
         rwraSnD3/AVQn36oTV8wgmKt0gpoNcMKQ/n4ZDdJC0q8nVmZfpaePYXktAuaLwtr/f4d
         P2vg==
X-Gm-Message-State: APjAAAWU5y/99A0O6rFhjSh2PkqtDDZonAbbw3NY67LNf+UY7LdpiXAP
        POSUjzkRkr7I3axQj/Hayair0UxQn6C+fLNvJylo6Q==
X-Google-Smtp-Source: APXvYqwfGG9UOGbr27UFMVNJJBbk12jOLo5AxlXG93d1P/c0iskcM/BLeVPzGBvUy8PL8zpvuBrBnO6PsRyjwbj3lKc=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr11955994lfn.44.1574427286678;
 Fri, 22 Nov 2019 04:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20191120143745.1254-1-geert+renesas@glider.be>
In-Reply-To: <20191120143745.1254-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 13:54:34 +0100
Message-ID: <CACRpkdb_6sT2mMUxCzXnV_q16SB2mQWrxVyRthQiXmvzOcn=yg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Grammar s/manager/managed/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 3:37 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied!

Yours,
Linus Walleij
