Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172DC78EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 17:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387952AbfG2PSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 11:18:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387693AbfG2PSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:18:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 778E4AD17;
        Mon, 29 Jul 2019 15:18:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jul 2019 08:18:10 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, mingo@redhat.com,
        jade.alglave@arm.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH 0/4] Various rwsem ACQUIRE fixes
Organization: SUSE Labs
In-Reply-To: <20190718134954.496297975@infradead.org>
References: <20190718134954.496297975@infradead.org>
Message-ID: <cc546d20114d7db8484e9adc8153a327@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-18 06:49, Peter Zijlstra wrote:
> These are the patches I ended up with after we started with Jan's
> patch (edited).

This series looks good to me.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
