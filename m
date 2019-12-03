Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2FB110170
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLCPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 10:42:58 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:43831 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLCPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:42:58 -0500
Received: by mail-qk1-f179.google.com with SMTP id q28so3817652qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ5+yklq7H8c4cLmSOwBTw3oeLZQUR/opCiWbrMVFHw=;
        b=LvI71To1VF/q1yq1S8AWadCBry6iIUKT0fW/YgdRM/ooPpIOdYifucaLUxQNDvQG7F
         6WzTXRJqm5WyTkJJC880WNiTSi0j3sBIJ+h9j/aQXV1hv3/d3ZIDdIDu3r7taktYQYte
         TBCa7Ej0WoDB6fdPMoEIuENBrL10zXSDUS/fzwei8eaF+RN3hq+WRJ623KS0Ldb1y6IU
         polQJbQ/r7z/0SKAkRYhzSf+HrZVGaSLYkLQzynpBo7aBxz+Thn1embz07roqjmHaylY
         wWLZHC16k5Fer1spanc1u/h+IYQmD+R5CwSKwrRgztKuMOVeRwdRwMU/mRfQrJKcNdNQ
         M2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ5+yklq7H8c4cLmSOwBTw3oeLZQUR/opCiWbrMVFHw=;
        b=C1q5vlcZxs8lNRKh9IwYu7ZvtnA4Vl/ixwCxyKOjmSM6homT7yoRpAr2wKKZwbxJ66
         5+SBK7Y+BWdPe5jyzznRFOldigMKW36EY4eckDE8aS3Ljm7ZhfwzSndheD8ZAxNw2ZiT
         /JpEp+HbcdhcyXNdDOlh+LMr5NkAbHIQ217sV6qgA8vJskP7EopYO3zZbIN3czzfPkd5
         ziTe4e9qxy4ly7x2N0BGx0kP/1bZ490l69bpqyyVys/iPjtz0fo8SvRzS9xcsuY0FmWD
         MxO2B+lKzKvCnQhGu/AyjeFW75TJyqDU8n4lX30vRNJ5U6MXK7pIUsHHY/1u57OyHTr/
         L5tw==
X-Gm-Message-State: APjAAAXCXs3MvS6G7EpH72tC7NRNJbEN+jKfwyYoxbBr3SfCD0ZajKgb
        jPpT6vOGrJwjwiPoAC3ZiIg=
X-Google-Smtp-Source: APXvYqz7zbichx9Xsf2WHw7Kn9aQgenAuKj3xnpaGD6uXIpcLyjtKIc7+jfvjey9Dv0KreS8xpQVTw==
X-Received: by 2002:ae9:de44:: with SMTP id s65mr5769090qkf.203.1575387777043;
        Tue, 03 Dec 2019 07:42:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:6ede])
        by smtp.gmail.com with ESMTPSA id f26sm1956315qtv.77.2019.12.03.07.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:42:54 -0800 (PST)
Date:   Tue, 3 Dec 2019 07:42:51 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Workqueues splat due to ending up on wrong CPU
Message-ID: <20191203154251.GC2196666@devbig004.ftw2.facebook.com>
References: <20191125230312.GP2889@paulmck-ThinkPad-P72>
 <20191126183334.GE2867037@devbig004.ftw2.facebook.com>
 <20191126220533.GU2889@paulmck-ThinkPad-P72>
 <20191127155027.GA15170@paulmck-ThinkPad-P72>
 <20191128161823.GA24667@paulmck-ThinkPad-P72>
 <20191129155850.GA17002@paulmck-ThinkPad-P72>
 <20191202015548.GA13391@paulmck-ThinkPad-P72>
 <20191202201338.GH16681@devbig004.ftw2.facebook.com>
 <20191203095521.GH2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203095521.GH2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 03, 2019 at 10:55:21AM +0100, Peter Zijlstra wrote:
> The below seems to not insta explode...

Paul, any chance you can run Peter's patch through your test?

Thanks.

-- 
tejun
