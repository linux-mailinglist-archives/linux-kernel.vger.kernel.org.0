Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0725E7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGCP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 11:26:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:33813 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:26:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 08:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="172168030"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2019 08:26:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 0/4] intel_th: Fixes for v5.2
In-Reply-To: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
Date:   Wed, 03 Jul 2019 18:26:07 +0300
Message-ID: <87sgrnta0g.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Greg,

Hi Greg,

> Here are the fixes I have for v5.2 cycle: two gcc warnings, one dma mapping
> issue and a new PCI ID. All issues were introduced in the same cycle, so no
> -stable involvement.
>
> All patches are aiaiai-clean. Signed git tag below. Individual patches in
> follow-up emails. Please consider pulling or applying. Thanks!

Just in case this got buried under other email.

Thanks,
--
Alex
