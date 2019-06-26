Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548BD56C51
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfFZOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 10:38:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36422 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728048AbfFZOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:38:58 -0400
Received: (qmail 2512 invoked by uid 2102); 26 Jun 2019 10:38:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jun 2019 10:38:57 -0400
Date:   Wed, 26 Jun 2019 10:38:57 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Tejun Heo <tj@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [RFC] deadlock with flush_work() in UAS
In-Reply-To: <1561536635.23604.8.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.1906261036550.1550-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Oliver Neukum wrote:

> Am Montag, den 24.06.2019, 10:22 -0400 schrieb Alan Stern:
> > But that pattern makes no sense; a driver would never use it.  The 
> > driver would just do the reset itself.
> 
> Correct. But UAS and storage themselves still need to use
> WQ_MEM_RECLAIM for their workqueues, don't they?

Perhaps so for uas.  usb-storage uses a work queue only for scanning 
targets, which doesn't interfere with the block I/O pathway.

Alan Stern

