Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE2613AC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgANOgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:36:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F39D2467D;
        Tue, 14 Jan 2020 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579012574;
        bh=T5lOeOIfe5v4wDnzEMxF9gplXVnotDMCTQTvcv3UkIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXz2epT6wC7ZsyOZs/ugBW4T0VsMsBCOQoQFDnOoHjnlOUpdoQC+p7wjiofWz/J6B
         bctwBbnsOHzjLSLLq/U1P+dO5rRZDZXnbrTVX8X4+ZtBY8KrkCISv10Acjq66tbgb3
         lEq9yDFikViGKy/kc22oJA0G+0w4qpnd9UJdlQR8=
Date:   Tue, 14 Jan 2020 15:36:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/24] Consolidate dummy_con initialization
Message-ID: <20200114143611.GA1838274@kroah.com>
References: <20191218211231.GA918900@kroah.com>
 <20191218214506.49252-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218214506.49252-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:44:42PM -0500, Arvind Sankar wrote:
> This series moves initialization of conswitchp to dummy_con into vt.c,
> and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.
> 
> The patches after the first two remove conswitchp = &dummy_con; from
> the various architecture setup functions where it currently appears. If
> the first two look ok, I was thinking of sending the others
> individually.

Looks good, I've queued them all up now, thanks!

greg k-h
