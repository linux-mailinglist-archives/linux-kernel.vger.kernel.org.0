Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81778181C60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgCKPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:34:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:60243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgCKPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583940880;
        bh=qMTvCor3jpfyFKgrZ9wr9DsSBzIOqOTlphBmida8eK4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RuVgq6apKeIpfL7yIgcXFXy2jbBayyfh1TwPIu2dht6gHYx7ZJm+tNzak5ZQrJx+0
         IyB1YWkt5t9J+7U6Fszss0V/76E6dMVspVNZpBvcuWO8MQi1o98ayaCGjckbTDZUe0
         IuSuoLO+Yj7MgGo3n5or6Gm2Yt2c+lOtQr9d/seg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.81.10.6] ([196.52.84.30]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mk0Ne-1jaQuV48ds-00kL0E; Wed, 11
 Mar 2020 16:34:40 +0100
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
Date:   Wed, 11 Mar 2020 15:34:38 +0000
MIME-Version: 1.0
In-Reply-To: <20200311152453.GB23704@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ipwOs7FlOcH+6J3PcePxcCRnbvZHEtKYkRq97SxCZoHICwHq3Qg
 2cMPf807JYMW2jipwGFmwqS+2FKbj09pzZS9ojZKYXyfQ7ATZcA8xOxp9NZaY47J7in3zJD
 egeVJhsFqz7R2pVZuZ9tqYc9V1oGQ7ksWYlMKhm12henmD5eGZ0B5HXC1gfYrfC8hN0KUN0
 GqYV3A5CtCPO+Bc2QAYfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5f+/dbDwjk=:pN0thVNlQMKusrih9u/FU5
 BwQB4ytnyRj0sf8lGxDl3fZqKxDRBXiOoWOqaI4d0pugdjDxGJjv+L7WAvUaXXUIgajj9FUq3
 W+mnNsHR3t9oOEvkXa4DSbjlm7tPQX78+hEmW5Th8FWc0OG5MmfML8zFfvlChj+F+/oO/O1t6
 TuOhvFapJ5KjrsS9ZnZf8qXvP6YP3PNkbTVuEppxBrx/m41SFhtDgAyg7Ad01mESt9jBF3y0T
 A6Vje+IYY/qtAzlp2n5ExLYVRuLZPnSkW7sbZh0sqpXVenleLZGzq9Ukmy5UK8skjGtLjoX4z
 0ZppStq8r+gxj+xcpON56jSidDvt2jCc/KV8O85sDAqKAD2SEaZUnHluJcM4+3u2aetxaC/3a
 Y9+oXjwRcoYoR+a0/Pz12ATKd8xA0FiebzdaiExoJ8kQAiE1FzfMByqzpgVTCYej0QyQYCxDr
 YNElQGjyD3oIi4mIZeCnRjEw0Qork28+8faMluWYnNT2RC3iN+xUBuwoh0fDQkcQJZcZN6WZf
 QMLSXw4SUjej8AceXJGUJrzHsotMNqlsqfHV/W67acOu96VChlswI5zdJ/V23FbqSS1TVrYaj
 xA0BMB4NFpYGUsxRDAfwFvKiquLSrfo+HV6nBD3BD52PuEv6fbe6AYOnOMzenDHyMTJNShUe+
 PrKI7zEW2ghdTzPwF+eQdhKP0WDTKffOBv1LHtDarDlw2mK7i56Gjt1KE7xBDWRQS/jv9cCtC
 QRTItsbS4C+eynjd2xs4A/7djHU0dDq3YRlm2p2K1TOhhL660O6KCx6BK+fvf57ujVSx0vqIO
 M6RyB4yOKZO6aNedwOPK8rRHw2z1c9SfIdf/GcT2lO25DJkaPftSkorlQCFDc+b9mX1yJe28O
 PwsB033dop/ltjEodf4q1N5y3KI2VM9FufCL/NzpIwSH8UhvUOIBPAxYQ8AieuCBC4uqdkhEe
 IypiD3vYee2IKhkHUxEzHvLOx9WdNs05CnSJSyXt1jhw19Q/5s6EEonuQr8PSdnK8amkbh4Vl
 /zOBhoVa1NdOQRgCx345q3dtQ2J1iFe6/PhG829OdK7kncpDEC7SiAsWDbNyKvk4J3EyB+o+S
 mZ+ybqE9T3tAbaxjl0oAgpCAU5qubNp6+dc3fomhLU8QgnqBkgTznPE9i1vQL8uABOsCCYGu9
 C14BALcNfVu0iMAFPDQuWGhQkzoAqUg9ukaoqcG6SBnz9e0k4DARaAxwCYEklai/0ehHuviw7
 Gdw54J368hjobO/wt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 3:24 PM, Christoph Hellwig wrote:
> pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;

This patch makes no difference.

The kernel panics with the same call trace which starts with:

RIP: 0010:kmem_cache_alloc_trace
...

? acpi_ds_create_walk_state
acpi_ds_create_walk_state
acpi_ds_call_control_method
acpi_ds_parse_aml
acpi_ps_execute_method
acpi_ns_evaluate
acpi_ut_evaluate_object
...
