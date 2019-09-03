Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD6A6CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfICPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 11:19:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:60724 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:19:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 08:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="189840511"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2019 08:19:06 -0700
Date:   Tue, 3 Sep 2019 08:19:06 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Make git output use LANGUAGE=en_US.utf8
Message-ID: <20190903151906.GB10768@linux.intel.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
 <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
 <20190830171731.GB15405@linux.intel.com>
 <a8afdbf13db47e7650473c7f71384f177f3dff59.camel@perches.com>
 <2c0595c97811044a45e3d482e752d5877a14c06d.camel@perches.com>
 <bb9f29988f3258281956680ff39c3e19e37dc0b8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb9f29988f3258281956680ff39c3e19e37dc0b8.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 12:29:25PM -0700, Joe Perches wrote:
> git output parsing depends on the language being en_US english.
> 
> Make the backtick execution of all `git <foo>` commands set the
> LANGUAGE of the process to en_US.utf8 before executing the actual
> command using `export LANGUAGE=en_US.utf8; git <foo>`.
> 
> Because the command is executed in a child process, the parent
> LANGUAGE is unchanged.
> 
> Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
