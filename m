Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45518075D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCJStZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:49:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:44726 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgCJStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 278C6537;
        Tue, 10 Mar 2020 18:49:24 +0000 (UTC)
Date:   Tue, 10 Mar 2020 12:49:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Guilherme Piccoli <gpiccoli@canonical.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        swood@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, mingo@kernel.org,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Subject: Re: [PATCH] Documentation: Better document the softlockup_panic
 sysctl
Message-ID: <20200310124923.58845026@lwn.net>
In-Reply-To: <CAHD1Q_w26XP5fOcqW_toDLvEU0crt1dUUjiwCyWTn_U1-Nh=1g@mail.gmail.com>
References: <20200310151503.11589-1-gpiccoli@canonical.com>
        <20200310110554.1fc016ad@lwn.net>
        <CAHD1Q_w26XP5fOcqW_toDLvEU0crt1dUUjiwCyWTn_U1-Nh=1g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 15:20:15 -0300
Guilherme Piccoli <gpiccoli@canonical.com> wrote:

> On Tue, Mar 10, 2020 at 2:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > So this doesn't even come close to applying; could you respin it against
> > docs-next, please?  
> 
> Sure, will resubmit soon. I understand docs-next is just linux-next
> correct? I couldn't find any specific docs tree on kernel.org ...

That's what the MAINTAINERS file is for:

	T:	git git://git.lwn.net/linux.git docs-next

jon
