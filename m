Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E110405C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 17:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfKTQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 11:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfKTQKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:10:01 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C18D2071B;
        Wed, 20 Nov 2019 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574266200;
        bh=GOfJLazKNOGUF+DblV0QgkbUDg+AIwFteXE9cjv0msM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fEpvkFLc5PDAykz78tNIYyiCQH0w8l3fNWyP1lGOzZPRATcYb1fM4QaT2pyINmkDv
         q/kOuhvDKXlRTXR4IlsRdcyquuhi7xY4FRLZCM7hhAxUISxoTYbs3DCMA8iLtd8Mp5
         d4RwoNOQXZfVVGqZ0r4fSJ0hfiGrK+tJmjEjLfv4=
Received: by mail-qt1-f171.google.com with SMTP id j5so64551qtn.10;
        Wed, 20 Nov 2019 08:10:00 -0800 (PST)
X-Gm-Message-State: APjAAAV8JHXg3eGirZRurMrVJ5VDq8uZVVfPzPSXSrbu56Rc8KpyQurb
        KToMPKW8MYpjyFs0NGAcINcBm5ydnwxqHf19Kg==
X-Google-Smtp-Source: APXvYqw3p2yQb6xBvbD23JDCGsCZyWm+FuELn8bHCVj23z04Oy6XY0ZjLoc2HtFsISuVdqYEfqWjo3pI1Xk8fiVtv+I=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr3469968qtn.300.1574266199801;
 Wed, 20 Nov 2019 08:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20191120040045.81115-1-saravanak@google.com>
In-Reply-To: <20191120040045.81115-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Nov 2019 10:09:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4JQ7Oop5oWUYRCNA-xQrd0svQSPrp+y1F+Qux9xTRrQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4JQ7Oop5oWUYRCNA-xQrd0svQSPrp+y1F+Qux9xTRrQ@mail.gmail.com>
Subject: Re: [PATCH] of: Reduce log level of of_phandle_iterator_next()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> These error messages are mostly useful for debugging malformed device
> tree data.

A malformed DT is an error, no?

> So change these messages from error to debug messages to
> avoid spamming the end user. Any error messages that might actually be
> useful to the user is probably going to come from the caller of these
> APIs. So leave it to them to decide if they need to print any error
> messages.

Generally that pattern results in every caller doing their own message
which is the wrong way around IMO. And recent patches fix some of
those cases[1].

Rob

[1] https://lkml.org/lkml/2019/7/30/41
