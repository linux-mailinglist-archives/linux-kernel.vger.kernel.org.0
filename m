Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C61875D7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgCPWyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 18:54:31 -0400
Received: from ms11p00im-qufo17281501.me.com ([17.58.38.52]:54957 "EHLO
        ms11p00im-qufo17281501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732846AbgCPWyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584399269; bh=IKikRHcL5YKuxApp79H42YHUdr+KWA1t9QQPRbpAOxY=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=n02GayrTm1FL+rH6/S32fJguQYkLvMxs/wTUyfML/rri9pVXMGgmAKggB0HzoZ3v5
         PHWYXVrkhwgjt3dm/0eSJ+QbrQHlLAChs5TNIPKi4gcdRcdODT9DM4YL4tYI+bTUzi
         BchQ0Zw2zX8DsnKG4WjJbAqXRP9KkEZ57Nm6krRi34q3KlOWZGrw+BSCjrwy3qPEkp
         xV7KpL+dJBxPhNJtjAY6QKTBzlZQmB0RGM2dwn7liq2ov48nMgFBb3gFTsMUrMFiZ6
         94niKIXlVnv93mMJwjmGURsoOz2gqYccjOXF6TXIzlpRQPxPckt688JCf3ILdFsGZk
         VVQ2sUGMT+VJQ==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281501.me.com (Postfix) with ESMTPSA id 5A478B40633;
        Mon, 16 Mar 2020 22:54:28 +0000 (UTC)
Date:   Mon, 16 Mar 2020 18:54:26 -0400
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200316225426.GA147347@shwetrath.localdomain>
References: <20200314044453.82554-1-vijaythakkar@me.com>
 <20200314044453.82554-3-vijaythakkar@me.com>
 <34be3999-34ef-871f-0950-089a00e5b1dd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34be3999-34ef-871f-0950-089a00e5b1dd@amd.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=756 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003160094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

Sorry for the blunder, I was working on a different system for a day
that had my school git email that I forgot to change in the sign-off.
Should be all fixed up in v5.

-Vijay
