Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADDFDBCCA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406715AbfJRFRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 01:17:48 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39284 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfJRFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:17:47 -0400
Received: by mail-qk1-f177.google.com with SMTP id 4so4203741qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0ankXvMIvRkTZk3dLR1A9aHQ97LMyM5OOOZtIX7Iozk=;
        b=a6W4jKAihyR2DAorQFwaIbD/tcsFbwtmZT5ZhH87uKXJ4mUausGkrXSgF+HhhHBLSx
         G/oPOUOVhI7wTWjJG+xuqxk0ZoxXno5FAv7WjD3usvLop4rE30g2iJu8SatTdQ/WjX2i
         G+qUbUfz5gl+k78nrbS2NeJIb0sqNjhAXHsfToylfZau1NBJ9D7Y98j16IUUxCpjS7Oh
         rTZdYBhKrJVVC+M0x2S1N7wQ/SXl+jmpjcvJ1SYhoJj7d7rufNQBRF3tIF/AGtPpK9KF
         5H2fyiVNxMgvWlaWUM5CbL1jepm8XxIC1M3Ixay9FIE5DQuBDf9bhrLwujZkXgo94+nc
         oiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0ankXvMIvRkTZk3dLR1A9aHQ97LMyM5OOOZtIX7Iozk=;
        b=pX52TkCFjkP2o+DtsGp0UBiYyoTtCGy4I9Y6sOdaRKIAq08yNlVpkqeoGtn2onHxPP
         Aj/jbkg8fMn5fd4gCa91uWTgioICMcanG9cheTZlb7Jakr+7sPyHK2V6cDYoEFv5izbx
         O/vdcFv8l035PBPsJKraUcSR6HdonnVcdxr2yh6Oa+9xqvzcYsL64Gl5+Xzd2Q/C1tdW
         0zYdWeZVEnegKfDnMVY/PzHGJ0vHTyYl4LggA7F9VZ/k5eNj7gQK+3Zl/DpaChQnZnAG
         3HX1+Cn3jylQ6THrvapKm4az15WkDe0jQwtSJGhlESwvFQ15JsIUvNDDire5GycxcUS0
         5h6Q==
X-Gm-Message-State: APjAAAVaZmCVBOQlgD+qi5YtWvykB1n7WeJoIJrrLlAHf/705O0pYI9U
        nhhX8M82sibP41FplgpkaljcvaEv98E=
X-Google-Smtp-Source: APXvYqzancRHP9NlKKPWFZ5zDnjvcnLwivbBtuzPVWLW19H7v7aB/W4Nsjevr+ygqYdJcSsFCi5kUA==
X-Received: by 2002:a02:715e:: with SMTP id n30mr7021276jaf.120.1571369401285;
        Thu, 17 Oct 2019 20:30:01 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id a26sm1508255ioe.77.2019.10.17.20.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 20:30:00 -0700 (PDT)
Date:   Thu, 17 Oct 2019 20:29:59 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: RISC-V nommu support v5
In-Reply-To: <CAAhSdy1dvFzEh_WZ8aDNyCKi968Dwxm+ru6D0DF08QoOq3JjLA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1910172029170.3156@viisi.sifive.com>
References: <20191017173743.5430-1-hch@lst.de> <CAAhSdy1dvFzEh_WZ8aDNyCKi968Dwxm+ru6D0DF08QoOq3JjLA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Anup Patel wrote:

> It will be really cool to have this series for Linux-5.4-rcX.

It's way too big to go in via the -rc series.  I'm hoping to have it ready 
to go for v5.5-rc1.


- Paul
