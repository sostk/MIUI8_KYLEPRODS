.class public Landroid/os/ResultReceiver;
.super Ljava/lang/Object;
.source "ResultReceiver.java"

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/os/ResultReceiver$MyResultReceiver;,
        Landroid/os/ResultReceiver$MyRunnable;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator",
            "<",
            "Landroid/os/ResultReceiver;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field final mHandler:Landroid/os/Handler;

.field final mLocal:Z

.field mReceiver:Lcom/android/internal/os/IResultReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    new-instance v0, Landroid/os/ResultReceiver$1;

    invoke-direct {v0}, Landroid/os/ResultReceiver$1;-><init>()V

    sput-object v0, Landroid/os/ResultReceiver;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(Landroid/os/Handler;)V
    .locals 1
    .param p1, "handler"    # Landroid/os/Handler;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroid/os/ResultReceiver;->mLocal:Z

    iput-object p1, p0, Landroid/os/ResultReceiver;->mHandler:Landroid/os/Handler;

    return-void
.end method

.method constructor <init>(Landroid/os/Parcel;)V
    .locals 1
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroid/os/ResultReceiver;->mLocal:Z

    const/4 v0, 0x0

    iput-object v0, p0, Landroid/os/ResultReceiver;->mHandler:Landroid/os/Handler;

    invoke-virtual {p1}, Landroid/os/Parcel;->readStrongBinder()Landroid/os/IBinder;

    move-result-object v0

    invoke-static {v0}, Lcom/android/internal/os/IResultReceiver$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/os/IResultReceiver;

    move-result-object v0

    iput-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    .prologue
    const/4 v0, 0x0

    return v0
.end method

.method protected onReceiveResult(ILandroid/os/Bundle;)V
    .locals 0
    .param p1, "resultCode"    # I
    .param p2, "resultData"    # Landroid/os/Bundle;

    .prologue
    return-void
.end method

.method public send(ILandroid/os/Bundle;)V
    .locals 2
    .param p1, "resultCode"    # I
    .param p2, "resultData"    # Landroid/os/Bundle;

    .prologue
    iget-boolean v0, p0, Landroid/os/ResultReceiver;->mLocal:Z

    if-eqz v0, :cond_2

    iget-object v0, p0, Landroid/os/ResultReceiver;->mHandler:Landroid/os/Handler;

    if-eqz v0, :cond_1

    iget-object v0, p0, Landroid/os/ResultReceiver;->mHandler:Landroid/os/Handler;

    new-instance v1, Landroid/os/ResultReceiver$MyRunnable;

    invoke-direct {v1, p0, p1, p2}, Landroid/os/ResultReceiver$MyRunnable;-><init>(Landroid/os/ResultReceiver;ILandroid/os/Bundle;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_0
    :goto_0
    return-void

    :cond_1
    invoke-virtual {p0, p1, p2}, Landroid/os/ResultReceiver;->onReceiveResult(ILandroid/os/Bundle;)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    if-eqz v0, :cond_0

    :try_start_0
    iget-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    invoke-interface {v0, p1, p2}, Lcom/android/internal/os/IResultReceiver;->send(ILandroid/os/Bundle;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1
    .param p1, "out"    # Landroid/os/Parcel;
    .param p2, "flags"    # I

    .prologue
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    if-nez v0, :cond_0

    new-instance v0, Landroid/os/ResultReceiver$MyResultReceiver;

    invoke-direct {v0, p0}, Landroid/os/ResultReceiver$MyResultReceiver;-><init>(Landroid/os/ResultReceiver;)V

    iput-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    :cond_0
    iget-object v0, p0, Landroid/os/ResultReceiver;->mReceiver:Lcom/android/internal/os/IResultReceiver;

    invoke-interface {v0}, Lcom/android/internal/os/IResultReceiver;->asBinder()Landroid/os/IBinder;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeStrongBinder(Landroid/os/IBinder;)V

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method