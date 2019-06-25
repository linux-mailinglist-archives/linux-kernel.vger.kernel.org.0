Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01F6527F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfFYJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfFYJXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:23:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BB41356EC;
        Tue, 25 Jun 2019 09:23:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 76BE66085B;
        Tue, 25 Jun 2019 09:23:18 +0000 (UTC)
Date:   Tue, 25 Jun 2019 11:23:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: Some bug fixes for perf stat metrics
Message-ID: <20190625092317.GA20028@krava>
References: <20190624193711.35241-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624193711.35241-1-andi@firstfloor.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 09:23:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:37:07PM -0700, Andi Kleen wrote:
> Fix some bugs and regressions in perf stat --metrics support.
> 
> Also available in 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc perf/metric-fixes-1

looks good to me

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
