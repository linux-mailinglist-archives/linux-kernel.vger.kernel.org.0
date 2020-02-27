Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7C172AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgB0WP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:15:56 -0500
Received: from kernel.crashing.org ([76.164.61.194]:37082 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgB0WP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:15:56 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01RMEmjH029914
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Feb 2020 16:14:52 -0600
Message-ID: <025fe463a37a01a39e8b988530b36ce79210897b.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] printk/console: Fix preferred console handling
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Feb 2020 09:14:47 +1100
In-Reply-To: <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
References: <20200213095133.23176-1-pmladek@suse.com>
         <20200217130308.GA447@jagdpanzerIV.localdomain>
         <20200218095232.q6tqjmome4fhc6f5@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 10:52 +0100, Petr Mladek wrote:
> On Mon 2020-02-17 22:03:08, Sergey Senozhatsky wrote:
> > On (20/02/13 10:51), Petr Mladek wrote:
> > > Hi,
> > > 
> > > I send this on behalf of Benjamin who is traveling at the moment.
> > > It is an interesting approach to long terms problems with
> > > matching
> > > the console preferred on the command line.
> > > 
> > > Changes against v3:
> > > 
> > > 	+ better check when accepting pre-enabled consoles
> > > 	+ correct reasoning in the 3rd patch
> > > 	+ update a comment of CON_CONSDEV definition
> > > 	+ fixed checkpatch warnings
> > 
> > Looks good to me,
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patchset is commited in printk.git, branch
> for-5.7-preferred-console.
> 
Do you plan to send any of this to -stable ?

Cheers,
Ben.

