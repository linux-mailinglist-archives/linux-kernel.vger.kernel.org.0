Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277238E7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 11:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHOJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 05:03:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfHOJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:03:38 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyBfT-000871-G3; Thu, 15 Aug 2019 11:03:35 +0200
Date:   Thu, 15 Aug 2019 11:03:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kernel User <linux-kernel@riseup.net>
cc:     LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
In-Reply-To: <20190814121154.12f488f7@localhost>
Message-ID: <alpine.DEB.2.21.1908151054090.2241@nanos.tec.linutronix.de>
References: <20190813232829.3a1962cc@localhost> <20190813212115.GO16770@zn.tnic> <20190814010041.098fe4be@localhost> <20190814070457.GA26456@zn.tnic> <20190814121154.12f488f7@localhost>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019, Kernel User wrote:
> On Wed, 14 Aug 2019 09:04:57 +0200 Borislav Petkov wrote:
> 
> > IMO, what you want does not belong in sysfs but in documentation.
> 
> How would documentation (a fixed static text file) tell whether a
> particular system is vulnerable or not?
> 
> > I partially see your point that a table of sorts mapping all those CPU
> > vulnerability names to (possible) mitigations is needed for users
> > which would like to know whether they're covered, without having to
> > run some scripts from github,
> 
> Correct.
> 
> > but sysfs just ain't the place.
> 
> Then why is it currently used for some of the vulnerabilities?

It's used to denote vulnerability classes and their mitigations:

  - Spectre v1
  - Spectre v2
  - Meltdown
  - SSB
  - L1TF
  - MDS

We are not tracking subclasses and their individual CVEs. The sysfs
interface is accurate (including SMT state) and the mapping to subclasses
and CVEs can be done by user space tools if required.

Thanks,

	tglx
