Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495A040233
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 22:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391939AbfFKUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 16:34:02 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41610 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388533AbfFKUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:34:02 -0400
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [131.188.30.118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 1C5E2241864;
        Tue, 11 Jun 2019 22:34:00 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id 09A19341CD4; Tue, 11 Jun 2019 22:33:59 +0200 (CEST)
From:   Thomas Preisner <linux@tpreisner.de>
Cc:     linux@tpreisner.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
Date:   Tue, 11 Jun 2019 22:33:11 +0200
Message-Id: <20190611203312.13653-1-linux@tpreisner.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190529104552.146fa97c@oasis.local.home>
References: <20190529104552.146fa97c@oasis.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 10:45:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 29 May 2019 11:31:23 +0200
> Thomas Preisner <linux@tpreisner.de> wrote:
> 
> > The "oneshot" tracer records every address (ip, parent_ip) exactly
> > once.
> > As a result, "oneshot" can be used to efficiently create kernel
> > function
> > coverage/usage reports such as in undertaker-tailor[0].
> > 
> > In order to provide this functionality, "oneshot" uses a
> > configurable hashset for blacklisting already recorded addresses. This
> > way, no user space application is required to parse the function
> > tracer's output and to deactivate functions after they have been
> > recorded once. Additionally, the tracer's output is reduced to a bare
> > mininum so that it can be passed directly to undertaker-tailor.
> > 
> > Further information regarding this oneshot function tracer can also be
> > found at [1].
> > 
> > [0]: https://undertaker.cs.fau.de
> > [1]: https://tpreisner.de/pub/ba-thesis.pdf
> > 
> > Signed-off-by: Thomas Preisner <linux@tpreisner.de>
> >
> 
> Hi,
> 
> If you are only interested in seeing what functions are called (and
> don't care about the order), why not just make another function
> profiler (see register_ftrace_profiler and friends)? Then you could
> just list the hash table entries instead of having to record into the
> ftrace ring buffer.
> 
> -- Steve
Hello,

thank you very much for your feedback. According to it, I have revised
my patch to use the existing stat_tracer infrastructure which is also
used by the previously mentioned ftrace_profiler. As a result, my
oneshot profiler no longer uses the ringbuffer to store traced
functions. Instead, the hashsets are read directly and added into an
additional hashset to remove duplicate entries (over cpu cores)
altogether.

However, due to there not being any mechanism (that I am aware of) to
activate such stat tracers via kernel commandline this oneshot profiler
is now always active when selected. Therefore, it is no longer possible
to disable this tracer during runtime and thus, allocated memory is no
longer freed.

Yours sincerely,
Thomas Preisner


