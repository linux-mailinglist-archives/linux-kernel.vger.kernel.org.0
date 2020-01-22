Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF2145A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAVQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:56:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48645 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726005AbgAVQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579712205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NASuyEyKYkLSIlHTQ24JmoHojA+s1CTO2zBxCaYhsHE=;
        b=jR3nz3O4a7ojv3LuoWrY47VlQgDcTIaOYpCiAQJUED5ZhBBqCwJ6C+l7SRQGsOYRKbCp4c
        0RshWqG3rBJ/mHjJUoWZHmi3/NHLnCSXKoOQ1nXxZpoaRfXErNtNJQuitC8yT9idIW9WBt
        lsbeiqu/bTEJjdEIThPd4jlAhO94cgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-kTw0fLkqPS2hEdxFlzDRmA-1; Wed, 22 Jan 2020 11:56:42 -0500
X-MC-Unique: kTw0fLkqPS2hEdxFlzDRmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA13800D4E;
        Wed, 22 Jan 2020 16:56:41 +0000 (UTC)
Received: from localhost (unknown [10.36.118.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA3A5E248;
        Wed, 22 Jan 2020 16:56:38 +0000 (UTC)
Date:   Wed, 22 Jan 2020 16:56:37 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
Message-ID: <20200122165637.GD677983@stefanha-x1.localdomain>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
 <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
 <20200110095217.GB573283@stefanha-x1.localdomain>
 <801cf09a-759f-b6bf-e71b-02dbf0f1d513@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <801cf09a-759f-b6bf-e71b-02dbf0f1d513@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 07:54:06PM +0800, Liu, Jing2 wrote:
> > > > >        \end{note}
> > > > >      }
> > > > >      \hline
> > > > > @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\=
label{sec:Virtio Transport Options / Vi
> > > > >        accesses apply to the queue selected by writing to \field{=
QueueSel}.
> > > > >      }
> > > > >      \hline
> > > > > -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> > > > > -    Writing a value to this register notifies the device that
> > > > > -    there are new buffers to process in a queue.
> > > > > +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
> > > > > +    Reading from the register returns the virtqueue notification=
 configuration.
> > > > > -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> > > > > -    the value written is the queue index.
> > > > > +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / M=
MIO-specific Initialization And Device Operation / Notification Address}
> > > > > +    for the configuration format.
> > > > > -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> > > > > -    the \field{Notification data} value has the following format=
:
> > > > > +    Writing when the notification address calculated by the noti=
fication configuration
> > > > > +    is just located at this register.
> > > > I don't understand this sentence.  What happens when the driver wri=
tes
> > > > to this register?
> > > We're trying to define the notification mechanism that, driver MUST r=
ead
> > > 0x50 to get the notification configuration
> > >=20
> > > and calculate the notify address. The writing case here is that, the =
notify
> > > address is just located here e.g. notify_base=3D0x50, notify_mul=3D0.
> > I still don't understand what this means.  It's just an English issue
> > and it will become clear if you can rephrase what you're saying.
>=20
> Sure, let me try to explain it. :)
>=20
> The different notification locations are calculated via the structure
> returned by reading this register.
>=20
> le32 {
> =C2=A0=C2=A0=C2=A0 notify_base : 16;
> =C2=A0=C2=A0=C2=A0 notify_multiplier : 16;
> };
>=20
> location=3Dnotify_base + queue_index * notify_multiplier
>=20
> The location might be the same when mul=3D0, and furthermore, it might be
> equal to 0x50 (notify_base=3D0x50, notify_mul=3D0) so we make this regist=
er W
> too.
>=20
> So we said, the register is RW and W is only for such scenario.
>=20
> Feel free to tell me if it's still confusing.

I understand now:

  Devices that only require a single notify address may set
  notify_base=3D0x50 and notify_multiplier=3D0 to use the Queue Notifier
  register itself for notifications.  In this case the driver writes to
  Queue Notifier to notify the device that there are new buffers in a
  virtqueue.

Perhaps you could include this in the text.

> > > > > -    \lstinputlisting{notifications-le.c}
> > > > > -
> > > > > -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec=
:Virtqueues / Driver notifications}
> > > > > -    for the definition of the components.
> > > > > +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / M=
MIO-specific Initialization And Device Operation / Available Buffer Notific=
ations}
> > > > > +    to see the notification data format.
> > > > >      }
> > > > >      \hline
> > > > >      \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
> > > > >        Reading from this register returns a bit mask of events th=
at
> > > > > -    caused the device interrupt to be asserted.
> > > > > +    caused the device interrupt to be asserted. This is only use=
d
> > > > > +    when MSI is not enabled.
> > > > >        The following events are possible:
> > > > >        \begin{description}
> > > > >          \item[Used Buffer Notification] - bit 0 - the interrupt =
was asserted
> > > > > @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\la=
bel{sec:Virtio Transport Options / Vi
> > > > >      \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
> > > > >        Writing a value with bits set as defined in \field{Interru=
ptStatus}
> > > > >        to this register notifies the device that events causing
> > > > > -    the interrupt have been handled.
> > > > > +    the interrupt have been handled. This is only used when MSI =
is not enabled.
> > > > >      }
> > > > >      \hline
> > > > >      \mmioreg{Status}{Device status}{0x070}{RW}{%
> > > > > @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\l=
abel{sec:Virtio Transport Options / Vi
> > > > >        \field{SHMSel} is unused) results in a base address of
> > > > >        0xffffffffffffffff.
> > > > >      }
> > > > > +  \hline
> > > > > +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
> > > > > +    Reading from this register returns the global MSI enable/dis=
able status and maximum
> > > > > +    number of virtqueues that device supports.
> > > > > +    \lstinputlisting{msi-status.c}
> > > > > +  }
> > > > Why is it necessary to combine the number of virtqueues and global
> > > > MSI enable/disable into a single 16-bit field?
> > > Originally, we want this 16-bit Read-Only, so we put some RO things t=
ogether
> > > and separate
> > >=20
> > > enable setting command to next register.
> > >=20
> > > > virtio-mmio uses 32-bit registers.  It doesn't try hard to save reg=
ister
> > > > space so it's strange to do it here (11-bit number of virtqueue fie=
ld
> > > > but 32-bit QueueSel field).
> > > In order to improve performance/save register space,=C2=A0 we combine=
 some data
> > > together.
> > >=20
> > > For example, combine MSI cmd operator (e.g. enable/disable, vector se=
tup)
> > > with argument (e.g. 1/0,=C2=A0 queue index).
> > >=20
> > > But it seems we miss the consistency with QueueSel.=C2=A0 So do you t=
hink if the
> > > max queue number should be 32-bit,
> > >=20
> > > which means it must be the same with QueueSel? If so, I guess we need=
 some
> > > re-organization. :)
> > I suggest following the 32-bit register size convention unless there is
> > a specific reason why using other register sizes is absolutely necessar=
y.
>=20
> Yes, let's keep consistency with QueueSel and re-organize other registers=
.
>=20
> I feel concern why Available Bu=EF=AC=80er Notifcations (section describi=
ng
> VIRTIO_F_NOTIFICATION_DATA) makes vq index as 16bit?

As you mentioned, the valid range of virtqueue numbers is only 16 bits
due to non-MMIO parts of the specification using 16 bits.

However, I think it makes sense to stick to the MMIO transport 32-bit
register size convention for consistency.  Devices just won't support
values above 0xffff.

Stefan

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4ofsUACgkQnKSrs4Gr
c8jpJQgAkwY6jBtWqkvTC96YuKEAkir+ohEBSvoQ/i4KaAe6BdMqk8pIHdbtZh5u
3tZ8wbtOD9/g7jNBICwGGG75k8LozgRCHsvmyOS+e2jkQXF0z7nQqabCv7iXL7OJ
3w1c8+GMBI5JExEUhgG9fKYdYZjeScOPqZEkPsz/Kh1MkEHKSXjT+IW/M0mn/nfi
8+Nn+i1omJJSpaUhs5a3PIThsuiy9d8WoUGC7H2kY6rSStABaKmIAsXeGQOl4KHu
V8qgb9AlwcMSn+s4g//7HpoIG4UynJG7oPGbFVdhq3UB+F7xDMCLaUci/vz0nvt/
8SKdn0farlHbqXvutpDjHEfQEdvX9g==
=vT+Z
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

