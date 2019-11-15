Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C948CFD966
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKOJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 04:34:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbfKOJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573810469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lzawNQBmGA+jjj1+nr7/MFGmhoKRDvbgjKa9NHAufc=;
        b=gcZws/seIZAErAEEmS+m0XFSbvJOuf4lMqYZ3K7dMsgWeqgwdwZn38IN29rocgMXv69siL
        cKOclndh6l0K2LL1bQfKkjvrwNG/Ah9wJ73kb26F/daKrKmBRGMrz9N0+HsZWlspmzqL1J
        ZzTioAfPbNGS7LtUijLjUg90WqQBp2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-VKzwddh-P4W-IxqFdRfIlg-1; Fri, 15 Nov 2019 04:34:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5E6DB25;
        Fri, 15 Nov 2019 09:34:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 662FE5ED32;
        Fri, 15 Nov 2019 09:34:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Nov 2019 10:34:22 +0100 (CET)
Date:   Fri, 15 Nov 2019 10:34:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115093419.GA25528@redhat.com>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114191538.GC171963@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191114191538.GC171963@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VKzwddh-P4W-IxqFdRfIlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14, Andrei Vagin wrote:
>
> On Thu, Nov 14, 2019 at 03:27:06PM +0100, Adrian Reber wrote:
> ...
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index 1d500ed03c63..2e649cfa07f4 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> ...
> > @@ -174,24 +186,51 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >  =09pid->level =3D ns->level;
> >
> >  =09for (i =3D ns->level; i >=3D 0; i--) {
> > -=09=09int pid_min =3D 1;
> > +=09=09int tid =3D 0;
> > +
> > +=09=09if (set_tid_size) {
> > +=09=09=09tid =3D set_tid[ns->level - i];
> > +=09=09=09if (tid < 1 || tid >=3D pid_max)
> > +=09=09=09=09return ERR_PTR(-EINVAL);
>
> do we need to release pids what have been allocated on previous levels?

Heh ;) it is really amazing that nobody noticed this! Thanks Andrei.

> nr =3D -EINVAL;

retval =3D -EINVAL;

> goto out_free;

Oleg.

