Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6AFEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 19:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfD3RTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 13:19:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45095 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3RTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:19:48 -0400
Received: by mail-io1-f68.google.com with SMTP id e8so12869837ioe.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Pv9s52F3I3LTh2VPQsZjNjyJ0DVTJR+kD/NTUkgR0S8=;
        b=YkcFR/uq4HcHwd3D84lUTjLRHG1YztZpclAPb4MLDMq/RCzq11vaiV92gO1/bh21Ys
         4BV7ad77tDVZl510QEjIchwpZbRK69HFYSSfHfunwNVeQ0dFEStx/pJ6zi0iwrO7nlmH
         LXM2q5HUaZEJ4EUhEGr/laqrXSpbt3iNghk3pa5FK1rVuQdg3GIvRrw5kK0NtqXbPlnu
         +mjDRbISVUY1Q2PzQWudRQRuu03mDOIsYDnGBFi3OChnrKExujH4zRswIJY2kmYOeOL+
         hkR4RKy3wnjFPhWyHs4Kh4vPM93lFLtZ+FJh5BESoXP6ELHE/0RWoaK+hvd+WVagm2vN
         nOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Pv9s52F3I3LTh2VPQsZjNjyJ0DVTJR+kD/NTUkgR0S8=;
        b=ZoFn8qToSpmS6Xp5vpgft47rGsBpxrfMa4Ug/XZg3fC50tc4bSZkW3OmUqYkNu/8xd
         wpeCfC1pLCPeqe+FOdSYKQkh7vYtmY3Nh8N3iqNMUYig0WJX5FaLnkh64nkb1xzMcKvv
         vMwcV1IjDdPdcPO7RKWJjaZ/G7bdeZHPXqqC2AnUJ9DAh9XwpbnkGUGulXq70efn3AOy
         xP5OfrByDTDeghJ8h5OcQJYnG7v03UIhHkRJ2DoaMS+FKEx3IyH0Z4Mn9CCMKHxjtg+N
         87tBgbqxEU1q/OaeM2LD/7A+BDOdxyjusSzo3ttmwPP3D5VIZVaH0fsp7RReBOh6FO8q
         lnXw==
X-Gm-Message-State: APjAAAVp6FMTa74bpKgmk3koSDgoIxS6nm200cvDGpl5uPioUSwA7TBI
        Nke4YwB1FThD3/Luxv4iDU+gqQ==
X-Google-Smtp-Source: APXvYqyU63AjN+GAZxxgezAz3u9ZMLLzLHCVYufHMiS7QiGi9a4cab8wPA8oBEa+cKGAzdZa4BXpsw==
X-Received: by 2002:a6b:8fce:: with SMTP id r197mr1003458iod.255.1556644788015;
        Tue, 30 Apr 2019 10:19:48 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id w184sm1661014ita.9.2019.04.30.10.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 10:19:47 -0700 (PDT)
Date:   Tue, 30 Apr 2019 10:19:46 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Paul Walmsley <paul.walmsley@sifive.com>
cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] mtd: spi-nor: add locking support for is25xxxxx
 device
In-Reply-To: <alpine.DEB.2.21.9999.1904301004060.7063@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1904301019280.7063@viisi.sifive.com>
References: <1556474956-27786-1-git-send-email-sagar.kadam@sifive.com> <1556474956-27786-4-git-send-email-sagar.kadam@sifive.com> <alpine.DEB.2.21.9999.1904301004060.7063@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Apr 2019, Paul Walmsley wrote:

> The above sequence indicates a kerneldoc-style comment, but the format of 
> the comment is not in kerneldoc format.  Please fix this comment to 
> conform with
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/kernel-docs.rst

This, rather:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/doc-guide/kernel-doc.rst#n57


- Paul
