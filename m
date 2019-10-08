Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862D6CFC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJHO3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:29:44 -0400
Received: from one.firstfloor.org ([193.170.194.197]:39246 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfJHO3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:29:44 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 10:29:44 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id D5AA586951; Tue,  8 Oct 2019 16:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1570544504;
        bh=qU+aOZ8e3XhF+99FLjM1jrujYQGQA+No8pJoZYO/5Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8kZOjeb4MtKFWbWeVqJPPRLt9CdIbDsFzN4tZvHefzobHsgfpkPFcSZsKLFL5tUh
         fTuZ3BJvecZMBRb5WgnM5GDjOOS0W/e6m2Jko2OwQq92qKMydlo+a41JXUpgXeFaih
         OUes1KKrjJFztWsFLfmI6JvceO/bBeG+73X3ZY0I=
Date:   Tue, 8 Oct 2019 07:21:44 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf data: Fix babeltrace detection
Message-ID: <20191008142143.ts5se4pzwfnfnbsh@two.firstfloor.org>
References: <20191007174120.12330-1-andi@firstfloor.org>
 <20191008115240.GE10009@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008115240.GE10009@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:52:40PM +0200, Jiri Olsa wrote:
> On Mon, Oct 07, 2019 at 10:41:20AM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The symbol the feature file checks for is now actually in -lbabeltrace,
> > not -lbabeltrace-ctf, at least as of libbabeltrace-1.5.6-2.fc30.x86_64
> > 
> > Always add both libraries to fix the feature detection.
> 
> well, we link with libbabeltrace-ctf.so which links with libbabeltrace.so
> 
> I guess we can link it as well, but where do you see it fail?

On FC30 the .so file is just a symlink, so it doesn't pull
in the other library.

$ gcc test-libbabeltrace.c -lbabeltrace-ctf
/usr/bin/ld:
/usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
undefined reference to `bt_packet_seek_get_error'
/usr/bin/ld:
/usr/lib/gcc/x86_64-redhat-linux/9/../../../../lib64/libbabeltrace-ctf.so:
undefined reference to `bt_packet_seek_set_error'
collect2: error: ld returned 1 exit status

$ ls -l /usr/lib64/libbabeltrace-ctf.so
lrwxrwxrwx 1 root root 26 Jan 31  2019 /usr/lib64/libbabeltrace-ctf.so
-> libbabeltrace-ctf.so.1.0.0

$ rpm -qf /usr/lib64/libbabeltrace-ctf.so
libbabeltrace-devel-1.5.6-2.fc30.x86_64

-Andi
