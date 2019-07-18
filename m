Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE906C4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfGRC2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 22:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfGRC2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:28:22 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB6320665;
        Thu, 18 Jul 2019 02:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563416901;
        bh=ARH8EQ0IsIwQgbUtuitrXQxkvZUjzgvXwHyXqAz7rHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pz+VlfMq7GcxdgJXU9N5Bt0VTh1JerW5UtHFzXt5vDZPDXN1vG0wz/+LmFWYVMv1n
         WzKHK0dNDnVyEIhFY3jYcjdsMJQg7NpmuoYxqg/aaZGsACaXVTYWh7Zv4kjttDcW1h
         no7J54cc9xiP6MpI2hGnquBvIwVHeYQn4usjVcuQ=
Date:   Thu, 18 Jul 2019 11:28:19 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Ingo Molnar <mingo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] driver-core, libnvdimm: Let device subsystems add
 local lockdep coverage
Message-ID: <20190718022819.GA15376@kroah.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341210661.292348.7014034644265455704.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156341210661.292348.7014034644265455704.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 06:08:26PM -0700, Dan Williams wrote:
> For good reason, the standard device_lock() is marked
> lockdep_set_novalidate_class() because there is simply no sane way to
> describe the myriad ways the device_lock() ordered with other locks.
> However, that leaves subsystems that know their own local device_lock()
> ordering rules to find lock ordering mistakes manually. Instead,
> introduce an optional / additional lockdep-enabled lock that a subsystem
> can acquire in all the same paths that the device_lock() is acquired.
> 
> A conversion of the NFIT driver and NVDIMM subsystem to a
> lockdep-validate device_lock() scheme is included. The
> debug_nvdimm_lock() implementation implements the correct lock-class and
> stacking order for the libnvdimm device topology hierarchy.
> 
> Yes, this is a hack, but hopefully it is a useful hack for other
> subsystems device_lock() debug sessions. Quoting Greg:
> 
>     "Yeah, it feels a bit hacky but it's really up to a subsystem to mess up
>      using it as much as anything else, so user beware :)
> 
>      I don't object to it if it makes things easier for you to debug."

Sure, apeal to my vanity and quote me in the changelog, it's as if you
are making it trivial for me to ack this...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:)


