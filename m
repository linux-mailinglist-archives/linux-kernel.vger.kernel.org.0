Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C95DDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 07:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfGCFce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 01:32:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:60537 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfGCFce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:32:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x635WGkN025368;
        Wed, 3 Jul 2019 00:32:17 -0500
Message-ID: <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
Subject: Re: [GIT PULL] FSI changes for 5.3
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Jul 2019 15:32:15 +1000
In-Reply-To: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 03:39 +0000, Joel Stanley wrote:
> Hello Greg,
> 
> We've not had a MAINAINERS entry for drivers/fsi, so this fixes that. It names
> Jeremy and I as maintainers, so if it works for you we will send pull requests
> to you each cycle.

Ack. I no longer work for IBM and thus cannot handle that subsystem
anymore.

> I realise this one is a bit late, but please consider including so we have a
> clear path for future submissions from 5.3 on.
> 
> This pull request contains two code changes. One touches hwmon and has an ack
> from Guenter as the hwmon maintainer.
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-5.3
> 
> for you to fetch changes up to 371975b0b07520c85098652d561639837a60a905:
> 
>   fsi/core: Fix error paths on CFAM init (2019-07-03 10:42:53 +0930)
> 
> ----------------------------------------------------------------
> FSI changes for 5.3
> 
>  - Add MAINTAINERS entry. There is now a git tree and a mailing
>  list/patchwork for collecting FSI patches
> 
>  - Bug fix for error driver registration error paths
> 
>  - Correction for the OCC hwmon driver to meet the spec
> 
> ----------------------------------------------------------------
> Eddie James (1):
>       OCC: FSI and hwmon: Add sequence numbering
> 
> Jeremy Kerr (1):
>       fsi/core: Fix error paths on CFAM init
> 
> Joel Stanley (1):
>       MAINTAINERS: Add FSI subsystem
> 
>  MAINTAINERS                | 13 +++++++++++++
>  drivers/fsi/fsi-core.c     | 32 ++++++++++++++++++++------------
>  drivers/fsi/fsi-occ.c      | 15 ++++++++++++---
>  drivers/hwmon/occ/common.c |  4 ++--
>  drivers/hwmon/occ/common.h |  1 +
>  5 files changed, 48 insertions(+), 17 deletions(-)

