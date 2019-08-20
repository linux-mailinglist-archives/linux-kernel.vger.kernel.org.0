Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB19624F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfHTOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 10:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfHTOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D987C10C0527;
        Tue, 20 Aug 2019 14:21:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05F496092F;
        Tue, 20 Aug 2019 14:21:32 +0000 (UTC)
Date:   Tue, 20 Aug 2019 16:21:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Joe Mario <jmario@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf c2c: Display proper cpu count in nodes column
Message-ID: <20190820142132.GI24105@krava>
References: <20190820140219.28338-1-jolsa@kernel.org>
 <20190820141652.GG24428@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820141652.GG24428@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 20 Aug 2019 14:21:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 11:16:52AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 20, 2019 at 04:02:19PM +0200, Jiri Olsa escreveu:
> > There's wrong bitmap considered when checking
> > for cpu count of specific node.
> > 
> > We do the needed computation for 'set' variable,
> > but at the end we use the 'c2c_he->cpuset' weight,
> > which shows misleading numbers.
> > 
> > Reported-by: Joe Mario <jmario@redhat.com>
> 
> You forgot to add this:
> 
> Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
> 
> Can you please confirm that that is the cset being fixed? This helps
> with backporters, stable@, etc.

oops sry, yes, that's correct commit

thanks,
jirka
