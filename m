Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC421785CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgCCWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:42:14 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35381 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgCCWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:42:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id z9so4211514lfa.2;
        Tue, 03 Mar 2020 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ+/6uwXVB6CkyLfTNiBmxLaJM91ko5pwiW+d2U99Zw=;
        b=kOdkCKMJ25uZAL9QZiaPnAkeF36l8NzO8A0yDYUAmejbrRU0i+9Omw9zg4asAHvTpR
         EeIeyTz3EJ01h7Z+1D73XCiYgd7/2nyU7LjEHg8UpqfklhBhOztAm+bjq8hrfEIXSXYS
         aigc6EcDKKqwArLmjQLZ9dFFgQyth/ZHZKGeSt0bdsvN32Tc2EJUwtAEUa6gCzL6+ZSL
         Pyy3GthcmMP53qZGUouny+dHWBguedGyB0yd6tt7FYCUtzB2VtusSXUKEJaENS+Zxumi
         jAxBtnIeGvE8WKTk+MpIjrQ4tFr93BlJd40xLP39cAhO3E/flbZe4zNPojl0OiOd2/NI
         t3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ+/6uwXVB6CkyLfTNiBmxLaJM91ko5pwiW+d2U99Zw=;
        b=jrGdQCEYP/Dze9VoOp47KOv4VpQnSakXqr6nfBArNfp/ZsKMfnxX1JkzjuOM/SEpc/
         JZ0+b4PQ2LWqutxJByWMbkCya7ykWVXNGbYQrg/VfH472OwAy7LUhJuo4nqjV/S82qCd
         hxYVxpPV/kw6/iIsE1FOSPi3RYzLesje4JBewTHY6d0I4768xBnOGrN1G/f+YEsO2tlP
         ONTkaRwh8KfHINMRUr8XDvf/2NQSsE/mmptZSVOV8kH8i1Ry4jliBJ+PksbqcjvOhMuP
         P8GUKFG4uhFWNIz+PRAnNzUyJqfe7JZxTEWim9RN6SIv82TkQsWmkAtXqdSJHOkVEozm
         wL4A==
X-Gm-Message-State: ANhLgQ1vPYsKtqJFiMRF0jeZrAit/7AY/QxFd3nwXPH0KkbNxX+vSFkA
        iRwRTGnLQ7n8IvfpGVWHm+MOUjuSGaSEKF/6wNc=
X-Google-Smtp-Source: ADFU+vuPr3JWnczjWq1ulvrGiPJF/rnWMBUcED8G8VW+qWk1fLE4W0ZIdsvpbMzcNfwztuwikWNxxO/l9aUlJPN6e5U=
X-Received: by 2002:a19:4344:: with SMTP id m4mr122964lfj.140.1583275330926;
 Tue, 03 Mar 2020 14:42:10 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
 <20200301100755.4532-1-hdanton@sina.com>
In-Reply-To: <20200301100755.4532-1-hdanton@sina.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Mar 2020 19:41:59 -0300
Message-ID: <CAOMZO5C6CG7HLxGu3wi0=GhSiVneXqCqEsYUQpKJX=xVRXaewA@mail.gmail.com>
Subject: Re: rcu_sched stalls on 4.14
To:     Hillf Danton <hdanton@sina.com>
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On Sun, Mar 1, 2020 at 7:08 AM Hillf Danton <hdanton@sina.com> wrote:

> If it would not take much difficulty to repro, see if it's likely down
> to a softirq hog.

Thanks for your suggestion.

I have asked the reporter to test it.

Thanks
