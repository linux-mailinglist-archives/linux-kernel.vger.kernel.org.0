Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBA1224EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 07:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLQGnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 01:43:10 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:35012 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:43:08 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 440B7200713;
        Tue, 17 Dec 2019 06:43:06 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id AC44820B04; Tue, 17 Dec 2019 07:42:54 +0100 (CET)
Date:   Tue, 17 Dec 2019 07:42:54 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     youling257 <youling257@gmail.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as
 stdin/stdout/stderr
Message-ID: <20191217064254.GB3247@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217051751.7998-1-youling257@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:17:51PM +0800, youling257 wrote:
> it caused Androidx86 /system/bin/sh: No controlling tty: open /dev/tty: No such device or address
> /system/bin/sh: warning: won't have full job control
> 
> Androidx86 alt+f1 root on tmpfs, alt+f2/f3 root on rootfs.

Are you sure it is caused by the patch you reference? It's really only
moving code around, and does not depend on tmpfs/rootfs. The exact same
three calls are made before and after the change, see
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b49a733d684e0096340b93e9dfd471f0e3ddc06d

The preceding patch (3/5) needs a bugfix which already is upstream, though.
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7de7de7ca0ae0fc70515ee3154af33af75edae2c

Thanks,
	Dominik
