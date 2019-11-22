Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E76107692
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 18:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKVRje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 12:39:34 -0500
Received: from ms.lwn.net ([45.79.88.28]:41512 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfKVRjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:39:33 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3327537B;
        Fri, 22 Nov 2019 17:39:33 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:39:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] docs, parallelism: Rearrange how jobserver
 reservations are made
Message-ID: <20191122103932.65d79f1f@lwn.net>
In-Reply-To: <20191121205929.40371-1-keescook@chromium.org>
References: <20191121205929.40371-1-keescook@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 12:59:26 -0800
Kees Cook <keescook@chromium.org> wrote:

> v2:
>     - correct comments and commit logs (rasmus)
>     - handle non-parallel mode more cleanly (rasmus)
>     - reserve slots 8 at a time (rasmus)
> v1: https://lore.kernel.org/lkml/20191121000304.48829-1-keescook@chromium.org
> 
> Hi,
> 
> As Rasmus noted[1], there were some deficiencies in how the Make jobserver
> vs sphinx parallelism logic was handled. This series attempts to address
> all those problems by building a set of wrappers and fixing some of the
> internal logic.
> 
> Thank you Rasmus for the suggestions (and the "jobhog" example)! :)

OK, I have applied this set for 5.5.

I do worry that this all looks a little complex and fragile.  I wonder if
there's a way that we could set up some sort of dependency chain that
would just tell make not to run the docs builds in parallel with anything
else?  That is more-or-less the effect of what we're doing anyway.

Meanwhile, though, this seems to work, so let's go with it :)

Thanks,

jon
