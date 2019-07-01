Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D661BB37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfEMQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 12:46:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46538 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:46:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id j49so4739664otc.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+3mAnr/b9UbwFExtpuE0rYNnd6nhYH9wGogKgfVlfk=;
        b=G4blTsXY5xUD5Hzls4SBx9CV2NXI5No8e2X6bt1a4Ya8OpJ5YNDp/z1weEkYzC3mf9
         ny/bT5/fCxy2RN4m85JsFsFR2LhOSG+a9f7+zMuhgKzC3ua9VRIeWcKeDqkF/s/haswR
         AO5Vf5duoZLPBM46NEUVfyjorSXyuwsH4z1kTMuV22u4qPBnKGlCxwLBnyvFVaQyTc5A
         nUy9VHZ58bTr4ixUdyJ+EK56q3WJcB9hp1ZUOM1QaaHuqx9dOs0wvZarvavUATuOkNRE
         TuIo0OoFQiUgb0gvNIC9xTwzyOypEYIh7vc1wD+0XCcoKly/9ZMYc1G6CYGE15nm+ySe
         RmLw==
X-Gm-Message-State: APjAAAXu69L6kw2rajRZBkyFePGbavrPwSmE/qONh/4t/No6qn+/hEPc
        yo2GybbtNltW3xQ4681UrYk3CC6Q3L4=
X-Google-Smtp-Source: APXvYqyoS+BzvjTUiPtp+WJhlX9ElDzKgLkwCqHb9EmMrZA+RtXHUnfJqC/65fW7RrOwBJLnzUTcAQ==
X-Received: by 2002:a05:6830:1545:: with SMTP id l5mr8331084otp.69.1557765960783;
        Mon, 13 May 2019 09:46:00 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id u127sm3926845oie.46.2019.05.13.09.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 09:45:59 -0700 (PDT)
Date:   Mon, 13 May 2019 09:45:55 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190513164555.GA30128@sultan-box.localdomain>
References: <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
 <20190509183353.GA13018@sultan-box.localdomain>
 <20190510151024.GA21421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510151024.GA21421@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:10:25PM +0200, Oleg Nesterov wrote:
> I am starting to think I am ;)
> 
> If you have task1 != task2 this code
> 
> 	task_lock(task1);
> 	task_lock(task2);
> 
> should trigger print_deadlock_bug(), task1->alloc_lock and task2->alloc_lock are
> the "same" lock from lockdep pov, held_lock's will have the same hlock_class().

Okay, I've stubbed out debug_locks_off(), and lockdep is now complaining about a
bunch of false positives so it is _really_ enabled this time. I grepped for
lockdep last time to try and find a concise way to show over email that lockdep
didn't complain, but that backfired. Here is better evidence:

taimen:/ # dmesg | grep simple_lmk
[   58.349917] simple_lmk: Killing droid.deskclock with adj 906 to free 47548 KiB
[   58.354748] simple_lmk: Killing .android.dialer with adj 906 to free 36576 KiB
[   58.355030] simple_lmk: Killing rbandroid.sleep with adj 904 to free 50016 KiB
[   58.582833] simple_lmk: Killing oadcastreceiver with adj 904 to free 43044 KiB
[   58.587731] simple_lmk: Killing .apps.wellbeing with adj 902 to free 48128 KiB
[   58.588084] simple_lmk: Killing android.carrier with adj 902 to free 43636 KiB
[   58.671857] simple_lmk: Killing ndroid.keychain with adj 902 to free 39992 KiB
[   58.675622] simple_lmk: Killing gs.intelligence with adj 900 to free 49572 KiB
[   58.675770] simple_lmk: Killing le.modemservice with adj 800 to free 41976 KiB
[   58.762060] simple_lmk: Killing ndroid.settings with adj 700 to free 74708 KiB
[   58.763238] simple_lmk: Killing roid.apps.turbo with adj 700 to free 54660 KiB
[   58.873337] simple_lmk: Killing d.process.acore with adj 700 to free 48540 KiB
[   58.873513] simple_lmk: Killing d.process.media with adj 500 to free 46188 KiB
[   58.873713] simple_lmk: Killing putmethod.latin with adj 200 to free 67304 KiB
[   59.014046] simple_lmk: Killing android.vending with adj 201 to free 54900 KiB
[   59.017623] simple_lmk: Killing rak.mibandtools with adj 201 to free 44552 KiB
[   59.018423] simple_lmk: Killing eport.trebuchet with adj 100 to free 106208 KiB
[   59.223633] simple_lmk: Killing id.printspooler with adj 900 to free 39664 KiB
[   59.223762] simple_lmk: Killing gle.android.gms with adj 100 to free 64176 KiB
[   70.955204] simple_lmk: Killing .apps.translate with adj 906 to free 47564 KiB
[   70.955633] simple_lmk: Killing cloudprint:sync with adj 906 to free 31932 KiB
[   70.955787] simple_lmk: Killing oid.apps.photos with adj 904 to free 50204 KiB
[   71.060789] simple_lmk: Killing ecamera.android with adj 906 to free 32232 KiB
[   71.061074] simple_lmk: Killing webview_service with adj 906 to free 26028 KiB
[   71.061199] simple_lmk: Killing com.whatsapp with adj 904 to free 49484 KiB
[   71.190625] simple_lmk: Killing rbandroid.sleep with adj 906 to free 54724 KiB
[   71.190775] simple_lmk: Killing android.vending with adj 906 to free 39848 KiB
[   71.191303] simple_lmk: Killing m.facebook.orca with adj 904 to free 72296 KiB
[   71.342042] simple_lmk: Killing droid.deskclock with adj 902 to free 49284 KiB
[   71.342240] simple_lmk: Killing .apps.wellbeing with adj 900 to free 47632 KiB
[   71.342529] simple_lmk: Killing le.modemservice with adj 800 to free 33648 KiB
[   71.482391] simple_lmk: Killing d.process.media with adj 800 to free 40676 KiB
[   71.482511] simple_lmk: Killing rdog.challegram with adj 700 to free 71920 KiB
taimen:/ #

The first simple_lmk message appears at 58.349917. And based on the timestamps,
it's clear that simple_lmk called task_lock() for multiple different tasks,
which is the pattern you think should cause lockdep to complain. But here is the
full dmesg starting from that point:

[   58.349917] simple_lmk: Killing droid.deskclock with adj 906 to free 47548 KiB
[   58.354748] simple_lmk: Killing .android.dialer with adj 906 to free 36576 KiB
[   58.355030] simple_lmk: Killing rbandroid.sleep with adj 904 to free 50016 KiB
[   58.432654] binder_alloc: 2284: binder_alloc_buf failed to map pages in userspace, no vma
[   58.432671] binder: 1206:1218 transaction failed 29189/-3, size 76-0 line 3189
[   58.582833] simple_lmk: Killing oadcastreceiver with adj 904 to free 43044 KiB
[   58.587731] simple_lmk: Killing .apps.wellbeing with adj 902 to free 48128 KiB
[   58.588084] simple_lmk: Killing android.carrier with adj 902 to free 43636 KiB
[   58.590785] binder: undelivered transaction 58370, process died.
[   58.671857] simple_lmk: Killing ndroid.keychain with adj 902 to free 39992 KiB
[   58.675622] simple_lmk: Killing gs.intelligence with adj 900 to free 49572 KiB
[   58.675770] simple_lmk: Killing le.modemservice with adj 800 to free 41976 KiB
[   58.736678] binder: undelivered transaction 58814, process died.
[   58.736733] binder: release 3099:3128 transaction 57832 in, still active
[   58.736744] binder: send failed reply for transaction 57832 to 1876:3090
[   58.736761] binder: undelivered TRANSACTION_COMPLETE
[   58.736766] binder: undelivered transaction 58752, process died.
[   58.762060] simple_lmk: Killing ndroid.settings with adj 700 to free 74708 KiB
[   58.763238] simple_lmk: Killing roid.apps.turbo with adj 700 to free 54660 KiB
[   58.863590] binder: release 1876:3089 transaction 58117 out, still active
[   58.863606] binder: undelivered TRANSACTION_COMPLETE
[   58.873337] simple_lmk: Killing d.process.acore with adj 700 to free 48540 KiB
[   58.873513] simple_lmk: Killing d.process.media with adj 500 to free 46188 KiB
[   58.873713] simple_lmk: Killing putmethod.latin with adj 200 to free 67304 KiB
[   59.014046] simple_lmk: Killing android.vending with adj 201 to free 54900 KiB
[   59.017623] simple_lmk: Killing rak.mibandtools with adj 201 to free 44552 KiB
[   59.018423] simple_lmk: Killing eport.trebuchet with adj 100 to free 106208 KiB
[   59.028460] binder: 1206:1206 transaction failed 29189/-22, size 100-0 line 3052
[   59.142592] binder_alloc: 2814: binder_alloc_buf, no vma
[   59.142620] binder: 1206:1218 transaction failed 29189/-3, size 76-0 line 3189
[   59.223633] simple_lmk: Killing id.printspooler with adj 900 to free 39664 KiB
[   59.223762] simple_lmk: Killing gle.android.gms with adj 100 to free 64176 KiB
[   59.540176] binder: undelivered transaction 59447, process died.
[   59.540763] binder: undelivered transaction 59446, process died.
[   59.815404] binder: 1206:3140 transaction failed 29189/0, size 12-0 line 2992
[   59.815418] binder: send failed reply for transaction 58117, target dead
[   60.977609] binder: 2105:2308 transaction failed 29189/-22, size 168-0 line 3052
[   63.040202] FG: fg_get_battery_temp: batt temperature original:350, tuned:309
[   63.040219] lge_battery: bm_watch_work: PRESENT:1, CHG_STAT:1, THM_STAT:2, BAT_TEMP:309, BAT_VOLT:4148182, VOTE_CUR:1000000, SET_CUR:1000000 
[   63.076086] msm-dwc3 a800000.ssusb: Avail curr from USB = 2
[   63.077278] PMI: smblib_handle_switcher_power_ok: Weak charger detected: voting 500mA ICL
[   63.080014] PMI: smblib_handle_switcher_power_ok: Reverse boost detected: voting 0mA to suspend input
[   63.081886] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.093639] fts_touch 5-0049: [FTS] Received Charger Disconnected Event
[   63.104656] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.122546] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.135620] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.156383] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.156897] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.160481] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.185029] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.189015] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.212484] lge_battery: bm_check_status: wake_unlocked: present[0] chg_state[2] vbus[0]
[   63.213039] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.231096] FG: fg_get_battery_temp: batt temperature original:350, tuned:310
[   63.233981] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.234663] msm-dwc3 a800000.ssusb: dwc3_msm_suspend: Calling suspend 1996
[   63.249755] msm-dwc3 a800000.ssusb: DWC3 in low power mode
[   63.250247] healthd: battery l=100 v=4148 t=31.0 h=2 st=3 c=748 fc=3229000 cc=289 chg=
[   63.250430] android_work: sent uevent USB_STATE=DISCONNECTED
[   63.294456] msm-dwc3 a800000.ssusb: Avail curr from USB = 0
[   70.492114] binder: undelivered transaction 86938, process died.
[   70.955204] simple_lmk: Killing .apps.translate with adj 906 to free 47564 KiB
[   70.955633] simple_lmk: Killing cloudprint:sync with adj 906 to free 31932 KiB
[   70.955787] simple_lmk: Killing oid.apps.photos with adj 904 to free 50204 KiB
[   71.060789] simple_lmk: Killing ecamera.android with adj 906 to free 32232 KiB
[   71.061074] simple_lmk: Killing webview_service with adj 906 to free 26028 KiB
[   71.061199] simple_lmk: Killing com.whatsapp with adj 904 to free 49484 KiB
[   71.164996] binder: undelivered transaction 87881, process died.
[   71.190625] simple_lmk: Killing rbandroid.sleep with adj 906 to free 54724 KiB
[   71.190775] simple_lmk: Killing android.vending with adj 906 to free 39848 KiB
[   71.191303] simple_lmk: Killing m.facebook.orca with adj 904 to free 72296 KiB
[   71.342042] simple_lmk: Killing droid.deskclock with adj 902 to free 49284 KiB
[   71.342240] simple_lmk: Killing .apps.wellbeing with adj 900 to free 47632 KiB
[   71.342529] simple_lmk: Killing le.modemservice with adj 800 to free 33648 KiB
[   71.482391] simple_lmk: Killing d.process.media with adj 800 to free 40676 KiB
[   71.482511] simple_lmk: Killing rdog.challegram with adj 700 to free 71920 KiB

No lockdep warnings!

Sultan
