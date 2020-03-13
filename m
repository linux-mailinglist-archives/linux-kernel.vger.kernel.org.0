Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4444184DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 18:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCMRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 13:48:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38439 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:48:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id n13so6775991lfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBLQZt8yXSmQFbpabglArI1vUJ7UPF/XypjmyBfvyVk=;
        b=DPlzu1PSzh+CHwPP/zN3dycxfFl9ZQkPe7eHqGyTGrPmz2GX+kTVwJrfWppBrAsi2F
         oD7Co+2bcJ9FjInhrR6aToEaP2w9vUXc0nphKSGAWXW+HMGODA+bMmLGYkYiZKmofQRd
         cvRhC1A5ChaKqZ+RaaPrjc/tF3zB+f1Aiios0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBLQZt8yXSmQFbpabglArI1vUJ7UPF/XypjmyBfvyVk=;
        b=JOhazXFS0UhWF7h6M+yy21ZnXohgOsYpPdvt4gXwo0QcgEvrqttFfc1Tn+BbsaBEc6
         Qyv1A0wbzwgi7lRUgbqLuH9OjtBRsQjigDKGjz27qpqk6f0Db+GUQ0Fwx0JA6sXJDuvI
         SgC9jkQHz5iTFH1jhOCRIKuyD9yo1SXZpCRTlinp8v8lGrZOoM2KnoRb+jPBrPgGGD1F
         6kaHgrDUrd8abQlEabADVKgX3cJYbWYYCRDPhxaOlkdLIvoh0HVx86JAAp7HoIv5GiAW
         zQauF+IT+pe4Vz55SWu54wcgEP0INRv3HrS7vMAJvCvirIn3z+eyvm/RcWNXhJLS6Se7
         avsg==
X-Gm-Message-State: ANhLgQ0Nj1zGPGbQ5SgrCuPFgDZet1BZOvKGz50ZBkP9hZ+qwBMYYNWV
        uhZqGCEYikXB5k230flYPHtf8m7bIBk=
X-Google-Smtp-Source: ADFU+vv5NKvyrC4c3Oc7ZzjaQJ2pM6dns0amGL6AgnhZMom0DTHEDBy5VvjLd8hxowM7LyXgNjp3sw==
X-Received: by 2002:a19:ee0f:: with SMTP id g15mr8953576lfb.213.1584121707737;
        Fri, 13 Mar 2020 10:48:27 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w203sm1620048lff.0.2020.03.13.10.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:48:27 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t21so8561891lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 10:48:26 -0700 (PDT)
X-Received: by 2002:ac2:5203:: with SMTP id a3mr9170677lfl.152.1584121706541;
 Fri, 13 Mar 2020 10:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <158404901390.1220563.13542240512778767032.stgit@warthog.procyon.org.uk>
In-Reply-To: <158404901390.1220563.13542240512778767032.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 10:48:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0NiejjfLkcZaChHqEt9b+NzRjYWOsoC0vsRMHLYMs8A@mail.gmail.com>
Message-ID: <CAHk-=wj0NiejjfLkcZaChHqEt9b+NzRjYWOsoC0vsRMHLYMs8A@mail.gmail.com>
Subject: Re: [PATCH] afs: Use kfree_rcu() instead of casting kfree() to rcu_callback_t
To:     David Howells <dhowells@redhat.com>
Cc:     Jann Horn <jannh@google.com>, linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Use kfree_rcu() instead, it's simpler and more correct.

Applied,

            Linus
