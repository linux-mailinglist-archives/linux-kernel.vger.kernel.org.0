Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7097FF5881
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKHU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 15:27:58 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:29322 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKHU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=657; q=dns/txt; s=iport;
  t=1573244877; x=1574454477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z3ZF6AR2UoafXM7ZmOur+x1U88cUCcFAdL1NrGTKQu8=;
  b=huKT36WbLhEU5RcbAmxnJYlRor9cnpT/mMxbjrss2PX/ELzHjLOVifq/
   XD4ER9Z8vGCIhO2VBiGFIVKKHa6eCgJff6972+FDwV7jIuIwCHfKxIA9V
   1BPPjNi8avkF545G4w7Fd/6Yc0kOGLy0S3O+fLhus7F/xTuUYz1gefLtk
   Q=;
X-IronPort-AV: E=Sophos;i="5.68,283,1569283200"; 
   d="scan'208";a="375898045"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Nov 2019 20:27:56 +0000
Received: from zorba ([10.24.83.59])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id xA8KRsA5016266
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Nov 2019 20:27:56 GMT
Date:   Fri, 8 Nov 2019 12:27:54 -0800
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lasse Collin <lasse.collin@tukaani.org>, Yu Sun <yusun2@cisco.com>,
        xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] lib/xz: Fix XZ_DYNALLOC to avoid useless memory
 reallocations.
Message-ID: <20191108202754.GG18744@zorba>
References: <20191108200040.20259-2-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108200040.20259-2-danielwa@cisco.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.83.59, [10.24.83.59]
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:00:40PM -0800, Daniel Walker wrote:
> From: Lasse Collin <lasse.collin@tukaani.org>
> 
> s->dict.allocated was initialized to 0 but never set after
> a successful allocation, thus the code always thought that
> the dictionary buffer has to be reallocated.
> 
> For the original commit to xz-embedded.git, please refer to:
> https://git.tukaani.org/?p=xz-embedded.git;a=commit;h=40d291b
> 
> Signed-off-by: Yu Sun <yusun2@cisco.com>


Yu made me aware that Lasse had sent this on Nov. 4. I would recommend you
take that patch, and disregard this one. Cisco is using it and we would like
to see it merged.

Daniel
