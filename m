Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DEC1D45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 10:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfI3ImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 04:42:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:48202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfI3ImK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:42:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECC0AAFD4;
        Mon, 30 Sep 2019 08:42:08 +0000 (UTC)
Message-ID: <f2c97e860f895613ba81b69c962660b0c712723a.camel@suse.de>
Subject: Re: [PATCH] scsi: core: Log SCSI command age with errors
From:   Martin Wilck <mwilck@suse.de>
To:     Laurence Oberman <loberman@redhat.com>,
        "Milan P. Gandhi" <mgandhi@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com
Date:   Mon, 30 Sep 2019 10:42:14 +0200
In-Reply-To: <3a8ee584f9846fba94d98d0e6941fefdcbed5d71.camel@redhat.com>
References: <20190923060122.GA9603@machine1>
         <471732f03049a1528df1d144013d723041f0a419.camel@suse.de>
         <3a8ee584f9846fba94d98d0e6941fefdcbed5d71.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-27 at 13:45 -0400, Laurence Oberman wrote:
> 
> Hi Martin
> 
> Agreed about log extraction, but turning that on with a busy workload
> in a production environment is not practical. We cant do it with
> systems with 1000's of luns and 1000's of IOPS/sec.
> Also second resolution is good enough for the debug we want to see.

I gather that you look at a specific problem where second resolution is
sufficient. For upstream, the generic usefulness should be considered,
and I don't think we can say today that better-than-second resolution
will never be useful, so I still vote for milliseconds.

Wrt the enablement of the option on highly loaded systems, I'm not sure
I understand. You need to enable SCSI logging anyway, don't you? Is it
an issue to have to set 2 sysfs values rather than just one?

Regards,
Martin

> 
> Regards
> Laurence
> 


