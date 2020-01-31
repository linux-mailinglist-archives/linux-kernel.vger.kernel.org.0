Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F013F14F2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 20:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAaTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 14:23:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725954AbgAaTXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580498600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YM162lFOZbA6IsWSVcqJtnitrz4+KcB6/sl6grgAghs=;
        b=bud6IoQgyTUuMOyI1kL3wgdQOAUSz7AYkFvF53kzToHqA0uhBHF4LTZ427rKIbVqlZ2cQj
        8CvWg5V0qsaDQr+MGnT/e9Q/6OAgxjC5/nBYe9N/MfE12dC705MaZYSxXLb/RuCGy3vPPB
        V587rzy445s5/peHWai6QN14WMnwROw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-AdHzt5F-PbiAhd5xZtaErg-1; Fri, 31 Jan 2020 14:23:17 -0500
X-MC-Unique: AdHzt5F-PbiAhd5xZtaErg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D467B1005512;
        Fri, 31 Jan 2020 19:23:15 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D8B8100EBA8;
        Fri, 31 Jan 2020 19:23:06 +0000 (UTC)
Subject: Re: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        will@kernel.org
Cc:     oleg@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, dave@stgolabs.net, jack@suse.com
References: <20200131150703.194229898@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b4cfb580-e7ed-d441-f615-e6056a9d2d75@redhat.com>
Date:   Fri, 31 Jan 2020 14:23:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200131150703.194229898@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/20 10:07 AM, Peter Zijlstra wrote:
> Hi all,
>
> This is the long awaited report of the percpu-rwsem rework (sorry Juri).
>
> IIRC (I really have trouble keeping up momentum on this series) I've addressed
> all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
> this in tip/locking/core for inclusion in the next merge.
>
> It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.
>
> Any objections to me stuffing it in so we can all forget about it properly?
>
>
The patchset looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

