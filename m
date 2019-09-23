Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D45BBF02
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 01:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408383AbfIWXfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 19:35:39 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55806 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfIWXfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:35:39 -0400
Received: by linux.microsoft.com (Postfix, from userid 1001)
        id 51E002008710; Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 3A89930705AF;
        Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
Date:   Mon, 23 Sep 2019 16:35:38 -0700 (PDT)
From:   James Morris <jamorris@linuxonhyperv.com>
X-X-Sender: jamorris@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
In-Reply-To: <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com> <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com> <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Linus Torvalds wrote:

> Should we just remove safesetid again? It's not really maintained, and
> it's apparently not used.  It was merged in March (with the first
> commit in January), and here we are at end of September and this
> happens.

My understanding is that SafeSetID is shipping in ChromeOS -- this was 
part of the rationale for merging it.


-- 
James Morris
<jamorris@linuxonhyperv.com>
