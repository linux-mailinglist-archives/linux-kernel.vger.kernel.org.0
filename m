Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5A138AD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfEDKWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 06:22:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfEDKWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:22:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so10848486wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWNwzUZQph6b2QxCuqVN9MRCxcgsPzNDS+iBy/bnb8w=;
        b=OSeQso2+aOPgrLh+CyyDVnTOKMSM+5E013ApCRXc/i+Y06oJSWVQnrQVsla/2RBk8o
         px2govNBEPt/izhDs5+/AEKIbZ9tFbWassWxtukdLdGA6uNEB0AoQBVOa6iXOCBbTl+4
         N5IEIiHPF57ktcyzL45fysBxEOGCM5AV1gTKfC85Qjmjn3zolrTIUQ/YKJ+LjRQ1glOz
         onUHbJ8SpV7UgtHqTaEqs3D0MtZqDrkAFb6ol+fFg0p4Unok5iOEruq3wpCBee+LQCE9
         lIqBV4Ia33BlnT3q0W1BCDj/o8BX2pNVYl2Sm1/R9WSaR80Gx6OV1KOMIU054VzoCpH/
         O08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWNwzUZQph6b2QxCuqVN9MRCxcgsPzNDS+iBy/bnb8w=;
        b=P1ER0J1VUljRABkQ1d5bUmivblHu3BGzlnGg+EZUR798daYBPuGoazjyYZm40NYANw
         3EoVEmpG4ILBXpnOg7fjb4vpfZy7SCeDpeUo9qIp5WNsQTsKGBIGqGLr2XPhnSYR2YB6
         QZ5uQCHkmec/sIQvaq1zdzL8leHkReuiJqS1gJ/PsaKHPFe2/CFS4rc1LYftM8Xuy/9+
         mfi3u1M3PRlKoNFD1JAfuOA6SLbizMYoSUV3nYKvZnjbN8Cmo2dhzNU3cgY8fSw+ONc+
         gJNBIBHIJfmiDhbR0LdND4hH9D5ML5suwPX8tWTFqNx5m43FVtKmfI9bbMMXxcOHzZwK
         h6Cg==
X-Gm-Message-State: APjAAAXSb0/93qQUW6BuUSDZykzDZtkkrIIw7KnAtcrMeVFpg1iytzWb
        Y7hhM9jOafcfrNGQX1DvHBmbJuCSqGJGDIbiK/U9qw==
X-Google-Smtp-Source: APXvYqxbZyapGEExoy/hobSrN0yi/H4Ms7813IcSBLFj11HGac+UOFFTQgnEKFBjcq4Wwg+MuxfICCONyX5th5rzxxY=
X-Received: by 2002:adf:edc8:: with SMTP id v8mr10923646wro.206.1556965326033;
 Sat, 04 May 2019 03:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190504101858.22772-1-jonas.gorski@gmail.com>
In-Reply-To: <20190504101858.22772-1-jonas.gorski@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 4 May 2019 12:22:26 +0200
Message-ID: <CAOiHx=nchxj5yTBDy4xnb-=AiJUwSX1_5nnwje=MbcTqVWVvxQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: reroute openwrt.org email addresses
To:     linux-kernel@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gabor Juhos <juhosg@freemail.hu>,
        John Crispin <john@phrozen.org>, Jo-Philipp Wich <jo@mein.io>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Steven Barth <steven@midlink.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 at 12:18, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> Since the fork and remerge of LEDE and OpenWrt.org, use of @openwrt.org
> addresses has been discouraged, and some addresses aren't even working
> anymore. To avoid patches being overlooked add appropriate mappings
> based on recent commit history in Linux and OpenWrt.

Great, one instantly replied with no such address, I'll try to get a
better one and send a V2.

Please ignore/drop.

Regards
Jonas
