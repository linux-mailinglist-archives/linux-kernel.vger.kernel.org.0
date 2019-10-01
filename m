Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1EC34C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfJAMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:49:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:36418 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbfJAMtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:49:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4B25C6A2;
        Tue,  1 Oct 2019 12:49:23 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:49:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     bhenryj0117@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/2] docs: security: update base LSM documentation file
Message-ID: <20191001064922.683d6dfe@lwn.net>
In-Reply-To: <201909251300.E9B819EB37@keescook>
References: <20190925101745.3645-1-bhenryj0117@gmail.com>
        <20190925101745.3645-2-bhenryj0117@gmail.com>
        <201909251300.E9B819EB37@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 13:06:28 -0700
Kees Cook <keescook@chromium.org> wrote:

> > +always appears first in the stack of LSM hooks. A
> > +:c:func:`security_add_hooks()` function (in ``security/security.c``)  
> 
> IIUC, the :c:func:`...()` marking isn't needed any more, just having a
> word followed by "()" should trigger the markup.

That is correct; we now want to stomp out :c:func: wherever we see it...

Thanks,

jon
