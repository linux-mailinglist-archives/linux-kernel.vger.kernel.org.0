Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56823145E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 23:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAVWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 17:14:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42189 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:14:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so1225738edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ivmc17qPjTOOAuUdzhqNiqR3zEltW4LD9LqEEw1NDNw=;
        b=BHGbEq/xaTtLBIiUeon/GNcbdWlI+7FVjS/M0NfxKqobePV6XrgRZAVxC7sFgJeS+m
         8C6wFjwngO8ckFW8+WAWYmGuP5wLWoVclrtsVZQVShlYM99aeSuHeFlp8pSMXs9E4haj
         q7ga8RD9O4sdIJcomQCo0SRBDvpSN8D+Ubxvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ivmc17qPjTOOAuUdzhqNiqR3zEltW4LD9LqEEw1NDNw=;
        b=EzXBJe81tojmsBHp1AYdSgD1dlLQ/wIWWhx38/xpdpr5WylDh4zPPZZ+NI4dQcS5DN
         u8O6xL07hUg118RsQIekGrw95R8f/cIeJmM5uhyCdHVg0QmG1qS62aFR0Y2G1djcL/AI
         30Em04M6d0RxDD23XqCSEowfgJOtGkZHAH99fve7A3dH/pfnaQ9skO6XLnfVckMog8bO
         Em7ehK8rT5480VXDcvYCP0mosrHs15T2MPIDv/PRXXI9AEqZIAIShibnzB5daW4NtXd1
         97y5RPe3pHADr68ci79zxil9FE6b7Xx0IyOwFa7WrY39oHprwMdxXFWLdjrwehFkatXP
         lspg==
X-Gm-Message-State: APjAAAX1DwiipXw3Kxy+bbXa/tAQMsjuoFbCF1N2f7FgMqsPzTwS2UxJ
        CYNPDJWE7Otc/qIPqxyqfCK6zyU37N5Rqfs66jdI
X-Google-Smtp-Source: APXvYqxxAuRSkM5R1WZRCKGlRoM2YkP6Eh1GVm/iglEYBdOipSXefg/OrjW34vBWhT4TlVnYCqP9Qz5nPT1dU6vh8eo=
X-Received: by 2002:a17:906:8298:: with SMTP id h24mr4434543ejx.64.1579731297154;
 Wed, 22 Jan 2020 14:14:57 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <20200121201014.52345-1-muraliraja.muniraju@rubrik.com> <19d3397e-f820-bae0-7e4f-93bafe7ce166@acm.org>
In-Reply-To: <19d3397e-f820-bae0-7e4f-93bafe7ce166@acm.org>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Wed, 22 Jan 2020 14:14:46 -0800
Message-ID: <CAByjrT-08OQPtf0ejsaBni6VGkSNGHmFmT_yp1_4H0oi-TBsPQ@mail.gmail.com>
Subject: Re: Re [PATCH] Adding multiple workers to the loop device.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see there was a submission that was done sometime ago to use
workqueues and was reverted
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e03a3d7a94e2485b6e2fa3fb630b9b3a30b65718
Hence used the approach of multiple workers this way. The current
change by default uses the default behaviour of 1 worker and one can
program the number of workers needed as a ioctl to scale as needed.

On Tue, Jan 21, 2020 at 8:01 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-01-21 12:10, muraliraja.muniraju wrote:
> > +     for (i = 0; i < lo->num_loop_workers; i++) {
> > +             kthread_init_worker(&(lo->workers[i]));
> > +             lo->worker_tasks[i] = kthread_run(
> > +                             loop_kthread_worker_fn, &(lo->workers[i]),
> > +                             "loop%d(%d)", lo->lo_number, i);
> > +             if (IS_ERR((lo->worker_tasks[i])))
> > +                     goto err;
> > +             set_user_nice(lo->worker_tasks[i], MIN_NICE);
> > +     }
>
> Unless if there is a really good reason, the workqueue mechanism should
> be used instead of creating kthreads. And again unless if there is a
> really good reason, one of the system workqueues (e.g. system_wq) should
> be used instead of creating dedicated workqueues.
>
> Bart.
