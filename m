Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AAA3047
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfH3G4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:56:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:61679 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfH3G4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:56:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 23:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="197975350"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 29 Aug 2019 23:56:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Aug 2019 09:56:27 +0300
Date:   Fri, 30 Aug 2019 09:56:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] software node: fixes for two smatch errors
Message-ID: <20190830065627.GH5486@kuha.fi.intel.com>
References: <20190829132116.76120-1-heikki.krogerus@linux.intel.com>
 <20190830063224.GD15257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830063224.GD15257@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:32:24AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 29, 2019 at 04:21:14PM +0300, Heikki Krogerus wrote:
> > Hi,
> > 
> > Both potentially unitialized variable errors.
> > 
> > Heikki Krogerus (2):
> >   software node: Fix use of potentially uninitialized variable
> >   software node: Fix use of potentially uninitialized variable
> 
> You can't send 2 different patches with identical subjects :(
> 
> Please make them unique as they should be doing different things.

Yes. I prepared these without thinking. Sorry about that.

thanks,

-- 
heikki
