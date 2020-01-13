Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7B13925D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAMNm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 08:42:59 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34759 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgAMNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:42:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so8481111qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ebRaEiWNJZRuQS+8brgIpZYm9LtU6d1+T5t6VKydh3Y=;
        b=fdmxS0wBohTq1pkWCQ2CTXeIMIJK31O1w7Yl3V7lHtFcr5Jc/P79yG2XOflZEJqP2Z
         jx6swCuexKcrh3nwOPmWyyiQ4QIv6+RcMxnNoTnjyaIh96G+IkNao2hBRtPex9qFjidg
         irOHyWXcynFHq7Gy0RB7PiopY3XQQ4OS2ZAUqSwNDxfvvq8jsE51dcg9cHtHE65xLqCQ
         9BQ/jBBLbQ5JRgv0g+2H6Jvzjlv9+TAM48jPtJVzkrBmGWrnbm/Y52lcM9K1zx/zjpg1
         twvDDkgpSwiqlatkh0Z/q7ozT3Z/HFQQ+8oOQ48ZGO3E/VGnhn+WYltpsmRyS5arIlUH
         +34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ebRaEiWNJZRuQS+8brgIpZYm9LtU6d1+T5t6VKydh3Y=;
        b=cmDLYZH28th2lBFZxapc+7kNbDe4yEuH7AqOrSIttTeUhEvlihIbWJgLQCLYp3+2Ti
         5oyEETeIHu/fl0PhAJTlHIC1af9sDVYneUOD902B6CGUfBSJ1EkR85URESdyc2WgUWz4
         2jsHC38tygXoPKXUQB2RgBtM/9WpGn0fAcxIBArkSKLELvsI7arKFnT8M2qioPsDV+xC
         ekBgEmciX0+P5CP93dbi5UqYeXRgNZYoWrDPCkxon5Xyvu6qbmXQUU1QX8yC5x9yKSLp
         qklFPJi59WnlqLsbDpyCHVePN6RWmP5cVWshq8jAk7pvsbQMdtyEzBXDMtj/NYpxZFGJ
         oUog==
X-Gm-Message-State: APjAAAV58EKnjPGrAMWznAIzWrj4sBTnf2OIO4p5+x7NUHbLDEWB7fLw
        gjYxMA+kErIUCqjG4iXllNlgCg==
X-Google-Smtp-Source: APXvYqxmgg8rongh+Fmg8bcqWMngfdaSMvVUMmgcVPb1BwUNwM+7gM7MxoqyAmyGpFu6zcA/gGsywg==
X-Received: by 2002:a05:620a:16c6:: with SMTP id a6mr16368641qkn.140.1578922976659;
        Mon, 13 Jan 2020 05:42:56 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s27sm4943171qkm.97.2020.01.13.05.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 05:42:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] sched/core: fix illegal RCU from offline CPUs
Date:   Mon, 13 Jan 2020 08:42:55 -0500
Message-Id: <58C3C45A-1C05-4900-B82D-5AAF7538B9C8@lca.pw>
References: <66e33eb5-e958-6dc8-2327-4168afdd9e1e@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, paulmck@kernel.org,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <66e33eb5-e958-6dc8-2327-4168afdd9e1e@i-love.sakura.ne.jp>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 13, 2020, at 3:22 AM, Tetsuo Handa <penguin-kernel@i-love.sakura.ne=
.jp> wrote:
>=20
> Is commit 7283094ec3db318e ("kernel, oom: fix potential pgd_lock deadlock f=
rom
> __mmdrop") about only softirq? Is it guaranteed that smp_call_function_sin=
gle()
> does not hit such race? Then just my overcareful...

That commit looks like a different issue. We are not call mmdrop() from soft=
irq here.=
