Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD31E35FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfFEOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 10:52:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:56765 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbfFEOwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:52:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:52:45 -0700
X-ExtLoop1: 1
Received: from araresx-wtg1.ger.corp.intel.com (HELO localhost) ([10.252.46.102])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2019 07:52:42 -0700
Date:   Wed, 5 Jun 2019 17:52:40 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20190605143526.GG11331@linux.intel.com>
References: <20190605120946.43b44032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605120946.43b44032@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 12:09:46PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tpmdd tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

I'm sorry about the incident and thank you for reporting this.

/Jarkko
