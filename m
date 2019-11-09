Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0132F60DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKISor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Nov 2019 13:44:47 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46607 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKISoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 13:44:46 -0500
Received: by mail-wr1-f45.google.com with SMTP id b3so10446938wrs.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4XI1X85wLVzP/SrohCDsY8Ew06poMLmDa6mRwgBF9Dw=;
        b=UGh3WLA4/FFSWy1DOkfxzZ2Vr8RzGE9s4D8t0HYzUs4MplEI/CF6V5BrEsAB6wwR3Y
         fYlK+IwMc70dU9xz8nUW2+FLqvPVGSIUx2L8QxVyNUaFQb3s4e9sZf+QXFHVM9e1xcBV
         8qQklAOVTXh9pu5CXQG2GOuKC8L8jnhld/OZZx9nSZeAJiTI5ZWmcAJ8EVju6wmJMJjb
         v+jS7/uToRUK3F3UajUM6+lovqbjkWQuBtyDXbTj19I8EAfsUa0b8SaO98codT5iNM0N
         jfcGEPdHMVkP1m440anr4jbipVfBHT2mCQs9T7Qrz9BpgtXLRSPg48yKO5PbsvHAdrxS
         jeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4XI1X85wLVzP/SrohCDsY8Ew06poMLmDa6mRwgBF9Dw=;
        b=dAniTLMdXGiNYTLsWrJFiI5znppY7s/PCAJMPDoi+bMZhudPpgaB+JNlZGbxiZa1QW
         UQBF7uQc9yDt6/fKE8mQ6P1pYWJIpmkGF0dYucMdN13U1nqEMev34sPEFPo1rOwjWiBV
         izDcPLsPCoSLey+QEN1sU1UJ+BdH61pK9eQ9mCfqkzK5k7M8X3LLXe7MzfeMKRDFg8a4
         RoxO32/R4CR7FGbCW+CkhsFYnk2sa8Rp6U51HDtm8uNVKGfevyrkkJnrUSnRgbdbJPVG
         KddMhj4xoLTKMivE5b/FAfJZJJeVJA0dqUFVU+HpSKyR+zqxhaEzOWtOcSw1vIxGkJdH
         qLlw==
X-Gm-Message-State: APjAAAXjqUROQW+SxcIU0AVqRuqy24CjZrn6BBYvbaqaqZndT/nUlBi2
        guzcZy86w1w2kEzeYXQbGw==
X-Google-Smtp-Source: APXvYqzv32EA1qkivhRH6rX7beyDR0RoTDaST3JRt0IsupMyx0C8u9NjxXcLpyYy9nT1yeZY30bkhQ==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr13239145wrn.71.1573325084384;
        Sat, 09 Nov 2019 10:44:44 -0800 (PST)
Received: from avx2 ([46.53.254.55])
        by smtp.gmail.com with ESMTPSA id j10sm4456103wrx.30.2019.11.09.10.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 10:44:43 -0800 (PST)
Date:   Sat, 9 Nov 2019 21:44:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     pbonzini@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191109184441.GA5092@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> statsfs is a proposal for a new Linux kernel synthetic filesystem,
> to be mounted in /sys/kernel/stats

I think /proc experiment teaches pretty convincingly that dressing
things into a filesystem can be done but ultimately is a stupid idea.
It adds so much overhead for small-to-medium systems.

> The first user of statsfs would be KVM, which is currently exposing
> its stats in debugfs

> Google has KVM patches to gather statistics in a binary format

Which is a right thing to do.
