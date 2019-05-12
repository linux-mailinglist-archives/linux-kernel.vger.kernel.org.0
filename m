Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4501ADED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfELTaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 15:30:22 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53228 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:30:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hPuAi-0005Hy-Ls; Sun, 12 May 2019 21:30:08 +0200
Message-ID: <bd29dc3e83eb8578eeb7e6c8f6c5afcf44947e7a.camel@sipsolutions.net>
Subject: Re: [PATCH 01/18] bitfield.h: add FIELD_MAX() and field_max()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alex Elder <elder@linaro.org>, Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, andy.shevchenko@gmail.com,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org
Date:   Sun, 12 May 2019 21:30:05 +0200
In-Reply-To: <adede2d0-c271-259d-a452-39f54f4895c7@linaro.org> (sfid-20190512_141854_980305_6355FA0E)
References: <20190512012508.10608-1-elder@linaro.org>
         <20190512012508.10608-2-elder@linaro.org> <8736lkji6e.fsf@codeaurora.org>
         <adede2d0-c271-259d-a452-39f54f4895c7@linaro.org>
         (sfid-20190512_141854_980305_6355FA0E)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-05-12 at 07:18 -0500, Alex Elder wrote:
> On 5/12/19 1:33 AM, Kalle Valo wrote:
> > Alex Elder <elder@linaro.org> writes:
> > 
> > > Define FIELD_MAX(), which supplies the maximum value that can be
> > > represented by a field value.  Define field_max() as well, to go
> > > along with the lower-case forms of the field mask functions.
> > > 
> > > Signed-off-by: Alex Elder <elder@linaro.org>
> > 
> > Via which tree is this going? I assume I do not have take it unless
> > someone says otherwise.
> 
> Sorry about that, perhaps I should have posted it separately.
> 
> I don't have an answer, but we could avoid having to coordinate
> if it went together with the rest.

It's unlikely to conflict, and I don't think anyone really thinks that
the file is "theirs" (being basically standalone), so I think you should
just take it with whatever code that needs it.

johannes

