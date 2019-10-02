Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C62C47C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 08:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfJBG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 02:28:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41233 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJBG2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:28:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so11766335lfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTszmpSpMPlVv5NO5j52vopWvFhJ/hDvGIs1sInZeE0=;
        b=WNwU+kt9M0gQO+bZUFeCQ2Uy2rYvSmCZlOXfGwcN9Ken31ATJxZchpQslOXJXpvCp/
         m/1ISDxuTA5dgvkKN8PAmHX0P7+EMq52GMV/QjsKpuIAsIuYlPhRXylBNiZ3DJswaVqY
         ZhXagFuEmGNISZGuRh0PlQlNSgkd2XLcnf5ETgfm/wviUq+MaFZ9ee/WxFEKmde/jfsc
         imQSWngBTadQ0kAhR38khptmuHTo7QdUiI59o2l7rI5kF/HJjxz2eX8EoGxx2Z1sU3lY
         JFMkx4eZS44bE14qZGWpCnBpOyMk5QFzC4dMEFZsDDqt4SNSQ3Ju4nYtt/NPXQRVuupp
         s1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTszmpSpMPlVv5NO5j52vopWvFhJ/hDvGIs1sInZeE0=;
        b=q01K0CjGNv56HVtUrbPEGLnPSBIiMM5pkqzPL5cZ26/tSYx8Xumb05wgkZqf6cULIq
         yIqqSJnlsvYVRe9qOmxexfxf7BNsR1ghbFwYe3AOT6kj4FenycDK2/WTBngVygYBZ638
         Rz9rGWMATiO8i48BAbMZSnqqixQUkAAeOabIo8IHVTsNN+/ng396H87XGQ5MuJtD4aKq
         rKl63NiWCMPnYRWo9fcACyO5LmYS7ocuO4Irjj0Lk7redAUGm3IOpM1D0r3weeJzJfeo
         qLTYfwYdsRCWbVadBC1WyGQV7rPiJvtvWjp35n6+1MPokOtGMLWUIkiYw4WO7m0zmwFK
         iTyQ==
X-Gm-Message-State: APjAAAWM6qaSvXo2iZYerTr0WwCjPYs5xJkaTdnjBDA6K6q0yR3TihNf
        iZAhWIINF5Hdp8dMB7LQcasTiPd+gF/7nq9Cuh5TNw==
X-Google-Smtp-Source: APXvYqxfpQj299sIJX4i65rHVAQmPwXXj80RqmfBCbpkjz94WBQjAB+NioCF61EeH+wGUijNRXt2XvGJdXZymZAgwno=
X-Received: by 2002:ac2:554e:: with SMTP id l14mr1208452lfk.32.1569997703468;
 Tue, 01 Oct 2019 23:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-4-git-send-email-vincent.guittot@linaro.org> <b1688b36-94d0-82aa-b8c3-a1aeab529bbb@arm.com>
In-Reply-To: <b1688b36-94d0-82aa-b8c3-a1aeab529bbb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Oct 2019 08:28:11 +0200
Message-ID: <CAKfTPtCqLGJDNHgG099wQ7Gy6A+63yP36cxAR_somNPEcJMxGA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] sched/fair: remove meaningless imbalance calculation
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019 at 19:12, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 19/09/2019 08:33, Vincent Guittot wrote:
> > clean up load_balance and remove meaningless calculation and fields before
> > adding new algorithm.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> We'll probably want to squash the removal of fix_small_imbalance() in the
> actual rework (patch 04) to not make this a regression bisect honeypot.

Yes that's the plan. Peter asked to split the patch to ease the review

> Other than that:
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
