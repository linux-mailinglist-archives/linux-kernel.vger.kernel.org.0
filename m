Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2487AFBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 13:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfIKLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 07:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfIKLxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:53:23 -0400
Received: from linux-8ccs.fritz.box (unknown [92.117.136.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BC9206A5;
        Wed, 11 Sep 2019 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568202803;
        bh=OSmcZkw6BPBclu8DItgUg1c2LHgWxUw2hDQLpnzeAuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmIFNhMfhOMjp0K1KNbbA5zKzB9PwL2X4bC8qCN5hckroV7y7Ajvuo2+qzMdu54cj
         uz+3L/UUpjv7RmF1yqLIWUVKhRNF3VqYUhqEoQDYhvW8AVvTCm/P2+Ma2J2tNi/4pB
         mV2rRWf0TnItS0hXVoF+r5xxpdTEOkbB7NGvsvB8=
Date:   Wed, 11 Sep 2019 13:53:18 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: move CONFIG_UNUSED_SYMBOLS to the sub-menu
 of MODULES
Message-ID: <20190911115318.GB6189@linux-8ccs.fritz.box>
References: <20190909110408.21832-1-yamada.masahiro@socionext.com>
 <20190909110408.21832-2-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190909110408.21832-2-yamada.masahiro@socionext.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/09/19 20:04 +0900]:
>When CONFIG_MODULES is disabled, CONFIG_UNUSED_SYMBOLS is pointless,
>thus it should be invisible.
>
>Instead of adding "depends on MODULES", I moved it to the sub-menu
>"Enable loadable module support", which is a better fit. I put it
>close to TRIM_UNUSED_KSYMS because it depends on !UNUSED_SYMBOLS.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Jessica Yu <jeyu@kernel.org>
