Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05701355C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgAIJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:29:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:32330 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbgAIJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:29:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:29:07 -0800
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="216242055"
Received: from vmastnak-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.37.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 01:29:05 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        intel-gvt-dev@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, hang.yuan@intel.com,
        dri-devel@lists.freedesktop.org, zhiyuan.lv@intel.com
Subject: Re: [PATCH 2/3] drm/i915/gvt: make gvt oblivious of kvmgt data structures
In-Reply-To: <5e98e9666bfeb275ec168df24bb8e9a33781229e.camel@cyberus-technology.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de> <20200106140622.14393-2-julian.stecklina@cyberus-technology.de> <87tv56qm9m.fsf@intel.com> <5e98e9666bfeb275ec168df24bb8e9a33781229e.camel@cyberus-technology.de>
Date:   Thu, 09 Jan 2020 11:29:22 +0200
Message-ID: <87zhexj7v1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Julian Stecklina <julian.stecklina@cyberus-technology.de> wrote:
> On Wed, 2020-01-08 at 12:24 +0200, Jani Nikula wrote:
>> On Mon, 06 Jan 2020, Julian Stecklina <julian.stecklina@cyberus-technology.de>
>> wrote:
> [...]
>> > +	/* Hypervisor-specific device state. */
>> > +	void *vdev;
>> 
>> I have no clue about the relative merits of the patch, but you can use
>> the actual type for the pointer with a forward declaration. You don't
>> need the definition for that.
>> 
>> i.e.
>> 
>> struct kvmgt_vdev;
>> ...
>> 	struct kvmgt_vdev *vdev;
>
> The goal here is to make the GVT code independent of the hypervisor backend.
> Different hypervisor backends need to keep different per-device state, so using
> the KVM type here defeats the purpose.
>
> I assume this is not only useful for us, but also for other hypervisor backends,
> such as Xen or 3rd-party hypervisors.

Right, carry on, sorry for the noise. ;)

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
